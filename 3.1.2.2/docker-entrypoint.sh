#!/bin/sh

if [ "$1" = 'asadmin' ]; then
    if [ "$AS_ADMIN_PASSWORD" ]; then
        echo "AS_ADMIN_PASSWORD=" > /tmp/glassfishpwd
        echo "AS_ADMIN_NEWPASSWORD=${AS_ADMIN_PASSWORD}" >> /tmp/glassfishpwd

        # Change the admin password
        asadmin --user=admin --passwordfile=/tmp/glassfishpwd change-admin-password --domain_name domain1

        # Log in the admin user
        # 
        # While using the `asadmin login` command is the proper way to do it,
        # there doesn't seem to be a way to pipe input to respond to its
        # interactive prompts for the username and password.
        #
        #   printf "admin\n${AS_ADMIN_PASSWORD}\n" | asadmin login
        #
        # Therefore, manually generate the .asadminpass file to "login".
        
        AS_ADMIN_PASSWORD_GFBASE64=`echo -n "$AS_ADMIN_PASSWORD" | base64`
        echo "asadmin://admin@localhost:4848 $AS_ADMIN_PASSWORD_GFBASE64" > /root/.asadminpass
        chmod 600 /root/.asadminpass

        if [ "$AS_ADMIN_ENABLE_SECURE" ]; then
            echo "AS_ADMIN_PASSWORD=${AS_ADMIN_PASSWORD}" > /tmp/glassfishpwd
            asadmin start-domain            
            
            asadmin --user=admin --passwordfile=/tmp/glassfishpwd enable-secure-admin
            
            # Call asadmin at least once to establish a trust with the
            # self-signed certificate for the admin API.
            # asadmin --interactive=false version

            asadmin stop-domain
        fi

        rm /tmp/glassfishpwd
    fi

    exec "$@"
fi

exec "$@"
