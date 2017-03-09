From: yangshukui@huawei.com (yangshukui)
Date: Thu, 9 Mar 2017 17:03:40 +0800
Subject: isolate selinux_enforcing
In-Reply-To: <58736B2E.90201@huawei.com>
References: <58732BCF.4090908@huawei.com> <58734284.1060504@huawei.com>
	<b7f75f65-592a-5102-0ac5-4d3aa43f0b55@huawei.com>
	<58736B2E.90201@huawei.com>
Message-ID: <58C11A6C.7000408@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

I want to use SELinux in system container and only concern the function 
in the container.
this system container run in vm and every vm has only one system container.

How do I use now?
docker run ... system-contaier /sbin/init
after init is running ,the following service is also running:

#this is the part of service file which will run in container after 
starting the container.
...
semodule -R     #use the policy in container.
restorecon /     #if needed
...

this method seem to work if host os and the docker images use the same 
content for rootfs, but if host use
redhat7 and docker images use centos7, it will deny many normal 
operations , and this let some host service not work.

If SELinux is permissive in host and enforcing in container ,it will 
resolve my problem. Unfortunately,
there is no namespace for SELinux.

Isolate SELinux is difficult and it has a lot of work to do, but is 
easier to isolate selinux_enforcing.

What do you think ?

Think you very much.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
