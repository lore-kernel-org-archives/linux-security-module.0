From: masanobu2.koike@toshiba.co.jp (masanobu2.koike at toshiba.co.jp)
Date: Tue, 6 Jun 2017 09:28:12 +0000
Subject: [RFC 0/3] WhiteEgret LSM module
In-Reply-To: <b2eb6ba0-9a66-0a02-073f-bf9b2ccf9952@schaufler-ca.com>
References: <20170530111157.5196-1-masanobu2.koike@toshiba.co.jp>
	<b2eb6ba0-9a66-0a02-073f-bf9b2ccf9952@schaufler-ca.com>
Message-ID: <c846324ce08d42f0833b532fa82e0b8f@TGXML276.toshiba.local>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> On 5/30/2017 4:11 AM, Masanobu Koike wrote:
> > WhiteEgret is an LSM to simply provide a whitelisting-type
> > execution control.
> >
> > An execution-whitelist, simply called whitelist, is a list
> > of executable components (e.g., applications, libraries)
> > that are approved to run on a host. The whitelist is used
> > to decide whether executable components are permitted to
> > execute or not. This mechanism can stop an execution of
> > unknown software, so it helps to stop the execution of
> > malicious code and other unauthorized software.
> > The whitelisting-type execution control works best in the
> > execution environments that are not changed for a long time,
> > for example, servers and control devices in industrial
> > control systems. This RFC provides a whitelisting-type
> > execution control implementation WhiteEgret.
> 
> Why is this better than setting the ownership and mode bits
> appropriately on your programs and libraries?
> 
> Beyond that, I'm pretty sure you could do this with AppArmor.
> If you're only doing the set-up once I think you can do this
> with SELinux (the proponents of SELinux can tell you how).
> I know you can do it with Smack. Why is this scheme better?

Thank you for your feedback.

We assume a system whose execution environment cannot be
changed for a long time. It includes industrial control
systems, and control devices are main target.
Although operators for such systems are experts for the
industrial controllers, they are often not familiar with
information systems or OSes. So it's worth providing
a mechanism they can manage.

Writing down whitelisting like access control is as follows.
  subjects - all
  objects - each permitted executable component
  permission - yes
So operators have to know only name of permitted executable
components to make a whitelist or change it. Reducing the
number of items to be set helps operators manage the systems.

However, we assume the following for the above systems:
(1) Root is not compromised.
(2) The host does not have malicious code in initial state.
(3) Using a whitelist and a WEUA requires root privilege.
Relaxing these assumptions are welcome.

> 
> >
> > Features of WhiteEgret
> >
> > - Easier initial setup
> > All you have to do is to make a whitelist.
> 
> In practice whitelists are built by starting with everything
> and deleting items until things stop working, then putting
> them back. Whitelists are theoretically great, but very difficult
> to build and maintain in the real world.

It is true that managing whitelist for information systems
is a hard task because their execution environments are
changed frequently.
On the other hand, for such devices that continue to do the same
tasks for many years, we can use the same whitelist for a long
time once the whitelist is established. When the host does not
have malicious code in initial state, we can just register all
executable components in the host to the whitelist.

> 
> >  The whitelist
> > shall contain all components that should be permitted
> > execution in the host. When we assume that the host does
> > not have malicious code in initial state, we just register
> > all executable components in the host to the whitelist.
> > The whitelist of WhiteEgret is assumed to contain at least
> > an absolute path and a hash value of the permitted
> > executable components.
> > WhiteEgret does not require policy generation which,
> > in general, is difficult and takes time for users.
> 
> Creating a proper whitelist is every bit as difficult as
> some aspects of policy generation. Granted, it's easier
> than generating SELinux policy or a proper Smack configuration,
> but the protection is a subset of what those systems provide.
> 
> > - Shorten downtime in system updating
> > According to system update, we should update the whitelist.
> > It will take a short time. Consequently, system downtime
> > due to security configuration update can be reduced.
> >
> > - Less restriction on operational environment
> > WhiteEgret does not depend on a file system, or on TPM.
> > Thus WhiteEgret has less restriction on operating environment.
> >
> > Mechanism of WhiteEgret
> >
> > WhiteEgret requires a user application called WhiteEgret User
> > Application (WEUA, for short). WhiteEgret utilizes the
> > bprm_check_security hook and the mmap_file hook.
> > WhiteEgret asks WEUA whether an executable component hooked
> > by the above hooks is permitted to execute or not.
> 
> Really, really bad idea. One visit from the OOM killer and
> your system is dead. One user space exploit and your system
> is compromised. Performance will be dreadful. Deadlocks, races
> and stalls, oh my!

Thank you for the pointing out. We also recognized similar kind
of problems. It is true that some mechanisms are necessary to
save systems from WEUA failures.
But there are some ways in user space to deal with problems
caused by user space application. For example, cgroups prevents
OOM killer from killing WEUA by separating WEUA memory space
form other applications. 

> 
> > If the response from the WEUA is "permit", then WhiteEgret
> > continues to process the executable component. If the response
> > is "not permit", then WhiteEgret returns an error and blocks
> > the execution of the executable component.
> > The bprm_check_security hook is triggered by execve system
> > call, so execution by almost all executable components are
> > hooked by the hook. However, because shared objects do not
> > invoke execve system call, WhiteEgret utilizes the mmap_file
> > hook to hook the memory mapping by a shared object.
> > Thus WhiteEgret ignores the mmap_file hook caused by
> > non-executable and by executable which calls execve system call.
> >
> > To ask the permission to a WEUA, WhiteEgret sends an
> > absolute path of the executable component to the WEUA.
> > Then the WEUA is expected to work as follows.
> > The WEUA sees if the absolute path is contained in the whitelist.
> > If it exists, the WEUA compares a hash value of the executable
> > component indicated by the absolute path with that in the
> > whitelist to see whether the executable component is changed
> > or not after the whitelist is made. The WEUA returns "permit"
> > if both tests are passed, otherwise returns "not permit".
> 
> How do you address symlinks, mount points, containers and chroot?

Because symlinks are resolved before WhiteEgret sends it to the WEUA,
execution control works normally according to the linked executable
component is included in the whitelist or not.

We doubt that mount or chroot commands on a device we assume
(such as industrial control device) are issued during operation
because they change operational environments. But if it happens,
then we have to prepare a whitelist assuming directory structure
of mount points or chrooted directories, or reconstruct a whitelist
after mounting or chrooting.

We cannot deal with containers at the moment as you pointed out.

Thank you.

Masanobu Koike

> 
> > WhiteEgret has two interface to communicate between kernel
> > space and user space: netlink and device driver. Although we
> > plan on using netlink, kernel Oops rarely happens when we use
> > netlink. Because we have not determined the cause yet,
> > we provide another communication method using device driver.
> > (See ToDo #1)
> >
> > The process of a WEUA is registered to WhiteEgret when it starts.
> > The CAP_NET_ADMIN capability is required for a process to
> > register to WhiteEgret. Once some process is registered,
> > after that, WhiteEgret rejects registration from the other
> > process by PID.
> > At the moment, authentication of WEUA by WhiteEgret at
> > registration has not implemented yet. Current authentication
> > function returns always "authenticated". (See ToDo #2)
> >
> > To use WhiteEgret
> >
> > Users have to prepare a whitelist and a WEUA to use WhiteEgret.
> > A sample WEUA is involved in samples/whiteegret/.
> >
> > To enable WhiteEgret, you are required to build the kernel using
> > normal procedures with CONFIG_SECURITY_WHITEEGRET=y and
> > CONFIG_DEFAULT_SECURITY_WHITEEGRET=y (or pass
> > "security=whiteegret" on kernel's command line).
> >
> > If you want to use device driver for communication between
> > kernel space and user space, then you are also required to
> > enable option CONFIG_SECURITY_WHITEEGRET_DRIVER.
> >
> > ToDo
> >  1. Bug fix of communication when using netlink.
> >  2. Authentication of WEUA by WhiteEgret when the WEUA
> >     is registered to WhiteEgret.
> >
> > Masanobu Koike (3):
> >   WhiteEgret: Add WhiteEgret core functions.
> >   WhiteEgret: Add device driver.
> >   WhiteEgret: Add an example of user application.
> >
> >  drivers/Kconfig                         |   2 +
> >  drivers/Makefile                        |   1 +
> >  drivers/security/Kconfig                |   1 +
> >  drivers/security/Makefile               |   1 +
> >  drivers/security/whiteegret/Kconfig     |  10 +
> >  drivers/security/whiteegret/Makefile    |   3 +
> >  drivers/security/whiteegret/we_driver.c | 295
> ++++++++++++++++++++++++
> >  drivers/security/whiteegret/we_driver.h |  32 +++
> >  samples/Kconfig                         |   6 +
> >  samples/Makefile                        |   2 +-
> >  samples/whiteegret/Makefile             |  25 +++
> >  samples/whiteegret/checkwl.c            |  80 +++++++
> >  samples/whiteegret/checkwl.h            |  29 +++
> >  samples/whiteegret/gennl.c              | 232 +++++++++++++++++++
> >  samples/whiteegret/gennl_user.h         |  32 +++
> >  samples/whiteegret/main.c               | 234 +++++++++++++++++++
> >  security/Kconfig                        |   7 +-
> >  security/Makefile                       |   2 +
> >  security/whiteegret/Kconfig             |  21 ++
> >  security/whiteegret/Makefile            |   7 +
> >  security/whiteegret/auth.c              |  19 ++
> >  security/whiteegret/auth.h              |  12 +
> >  security/whiteegret/dd_com.c            |  79 +++++++
> >  security/whiteegret/dd_com.h            |  19 ++
> >  security/whiteegret/gennl.c             | 382
> ++++++++++++++++++++++++++++++++
> >  security/whiteegret/gennl.h             |  32 +++
> >  security/whiteegret/gennl_common.h      |  43 ++++
> >  security/whiteegret/init.c              |  69 ++++++
> >  security/whiteegret/main.c              | 340
> ++++++++++++++++++++++++++++
> >  security/whiteegret/print_msg.h         |  19 ++
> >  security/whiteegret/request.c           | 248 +++++++++++++++++++++
> >  security/whiteegret/request.h           |  79 +++++++
> >  security/whiteegret/returntoexec.h      |  14 ++
> >  security/whiteegret/we.h                |  72 ++++++
> >  security/whiteegret/we_common.h         |  19 ++
> >  35 files changed, 2466 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/security/Kconfig
> >  create mode 100644 drivers/security/Makefile
> >  create mode 100644 drivers/security/whiteegret/Kconfig
> >  create mode 100644 drivers/security/whiteegret/Makefile
> >  create mode 100644 drivers/security/whiteegret/we_driver.c
> >  create mode 100644 drivers/security/whiteegret/we_driver.h
> >  create mode 100644 samples/whiteegret/Makefile
> >  create mode 100644 samples/whiteegret/checkwl.c
> >  create mode 100644 samples/whiteegret/checkwl.h
> >  create mode 100644 samples/whiteegret/gennl.c
> >  create mode 100644 samples/whiteegret/gennl_user.h
> >  create mode 100644 samples/whiteegret/main.c
> >  create mode 100644 security/whiteegret/Kconfig
> >  create mode 100644 security/whiteegret/Makefile
> >  create mode 100644 security/whiteegret/auth.c
> >  create mode 100644 security/whiteegret/auth.h
> >  create mode 100644 security/whiteegret/dd_com.c
> >  create mode 100644 security/whiteegret/dd_com.h
> >  create mode 100644 security/whiteegret/gennl.c
> >  create mode 100644 security/whiteegret/gennl.h
> >  create mode 100644 security/whiteegret/gennl_common.h
> >  create mode 100644 security/whiteegret/init.c
> >  create mode 100644 security/whiteegret/main.c
> >  create mode 100644 security/whiteegret/print_msg.h
> >  create mode 100644 security/whiteegret/request.c
> >  create mode 100644 security/whiteegret/request.h
> >  create mode 100644 security/whiteegret/returntoexec.h
> >  create mode 100644 security/whiteegret/we.h
> >  create mode 100644 security/whiteegret/we_common.h
> >
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
