From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 23 Apr 2018 10:04:19 -0700
Subject: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
Message-ID: <32eea1d6-450c-bc68-59d6-74bc5011ead2@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/23/2018 6:30 AM, David Herrmann wrote:
> Hi
>
> This series adds a new LSM hook for the socketpair(2) syscall. The idea
> is to allow SO_PEERSEC to be called on AF_UNIX sockets created via
> socketpair(2), and return the same information as if you emulated
> socketpair(2) via a temporary listener socket. Right now SO_PEERSEC
> will return the unlabeled credentials for a socketpair, rather than the
> actual credentials of the creating process.
>
> ...
>
> This series only adds SELinux backends, since that is what we need for
> RHEL. I will gladly extend the other LSMs if needed.

I would be very happy to see a proposed patch for Smack. It shouldn't
be much different from the SELinux version, with the exception that it
will use pointers to smk_known structures instead of secids. It would be
a big help, as someone just threw a whole new species of scorpion into
this pit.

>
> Thanks
> David
>
> [1] https://github.com/bus1/dbus-broker/blob/master/src/util/test-peersec.c
> [2] https://www.spinics.net/lists/selinux/msg22674.html
>
> David Herrmann (3):
>   security: add hook for socketpair(AF_UNIX, ...)
>   net/unix: hook unix_socketpair() into LSM
>   selinux: provide unix_stream_socketpair callback
>
>  include/linux/lsm_hooks.h |  8 ++++++++
>  include/linux/security.h  |  7 +++++++
>  net/unix/af_unix.c        |  5 +++++
>  security/security.c       |  6 ++++++
>  security/selinux/hooks.c  | 14 ++++++++++++++
>  5 files changed, 40 insertions(+)
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
