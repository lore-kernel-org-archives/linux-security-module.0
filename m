From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 6 Apr 2017 13:10:25 -0700
Subject: [PATCH RFC 00/11] LSM: Stacking for major security modules
In-Reply-To: <1491503171.4532.10.camel@tycho.nsa.gov>
References: <509e0281-9f8a-83c2-f9d6-5532903cda46@schaufler-ca.com>
	<1491503171.4532.10.camel@tycho.nsa.gov>
Message-ID: <c6d9da56-fd4d-e8e5-caa5-718de74db261@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/6/2017 11:26 AM, Stephen Smalley wrote:
> On Wed, 2017-04-05 at 14:39 -0700, Casey Schaufler wrote:
>> Subject: [PATCH RFC 00/11] LSM: Stacking for major security modules
>>
>> I am again sending this as an RFC. If you stop at patch 04 you can
>> use any combination of modules so long as you use only one of
>> SELinux and Smack. Patches 05-10 take you most of the way to complete
>> stacking, but cannot be said to completely address all the issues.
>> Patch 11 provides for management of the yet unused task blob.
>>
>> This patch set implements stacking for "major" security modules
>> that use cred and file blobs. Management of security blobs is
>> moved from the security modules and into the LSM infrastructure.
>> This has been proposed in the past by Serge Hallyn and David Howells.
>> This implementation owes much to their work.
>>
>> The bulk of the change is in abstracting use of blobs within the
>> security modules. This allows the modules to share a single blob
>> and hides the details from the code. There is 
>>
>> Modules are required to declare the amount of space they require
>> for each blob they use. Because modules deal with blobs during their
>> initialization the blob sizes must be declared prior to module
>> initialization. The module initialization becomes a two step process.
>>
>> Security module stacking is optional. If stacking is not configured,
>> the CONFIG_DEFAULT_SECURITY value is used, just as before. If
>> stacking
>> is configured using CONFIG_SECURITY_STACKING the modules desired for
>> the stack are selected individually. AppArmor would be selected by
>> specifying CONFIG_SECURITY_APPARMOR_STACKED. The
>> CONFIG_DEFAULT_SECURITY
>> is ignored. The security= boot option is still respected and has the
>> same behavior as before, allowing a single module to be used instead
>> of
>> the specified stack.
>>
>> To accommodate multiple active modules a security "context" is
>> defined to use a regular format:
>>
>> 	lsmname='lsmvalue'[,lsmname='lsmvalue']...
>>
>> This is not supported by any existing user space run time code.
>>
>> I have tested these patches in various configurations of Ubuntu and
>> Fedora. I have had much better success with SELinux in permissive
>> mode
>> than enforcing, but that appears to be a result of user space code
>> issues. Smack and SELinux together have limited success, again
>> because
>> of the context format.
> I think in order for this to be viable, it must not break existing
> userspace if CONFIG_SECURITY_STACKING=y if only one module is enabled.

If there's only one module enabled you don't need
CONFIG_SECURITY_STACKING=y. Nonetheless, I see the point.
It's lots cleaner if this can be a compile time
difference rather than something detected at run time,
but I'll factor that in to the next version.

>  Ideally, it wouldn't even break existing userspace with multiple
> modules, so long as they do not conflict in their usage of userspace
> APIs (e.g. if only one implements getpeersec_stream, why mutate its
> result and break userspace?).

Remember that
"system_u:object_r:netlabel_peer_t:s0" is a legitimate Smack label.

I don't think doing "System" vs
"selinux='system_u:object_r:netlabel_peer_t:s0',smack='System'"
on a per-API granularity is a good idea. The author of user space
code oughtn't be compelled to figure out which APIs will identity
the components and when they don't which security module will
provide the unadorned data.

At some point it would be a good idea to have a liblsm that
would make varying and/or multiple security modules easier to
deal with. I know systemd and dbus could use such a library to
good effect.

> At present, it breaks the selinux-testsuite even with
> CONFIG_SECURITY_STACKING=n, all in the inet_socket tests; looks like
> network labeling is broken.  FWIW, output was:

Thanks for running the tests. I'll be looking into this soonest.

>
> inet_socket/test ............ getsockopt: SO_PEERSEC: Protocol not
> available
> read: Connection reset by peer
> inet_socket/test ............ 1/33 
> #   Failed test at inet_socket/test line 27.
> inet_socket/client:  expected
> unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023, got 

I'd be interested to see what it got.

> inet_socket/test ............ 3/33 
> #   Failed test at inet_socket/test line 45.
> inet_socket/test ............ 26/33 
> #   Failed test at inet_socket/test line 219.
>
> #   Failed test at inet_socket/test line 227.
> inet_socket/test ............ 30/33 
> #   Failed test at inet_socket/test line 245.
>
> #   Failed test at inet_socket/test line 253.
> # Looks like you failed 6 tests of 33.
> inet_socket/test ............ Dubious, test returned 6 (wstat 1536,
> 0x600)
> Failed 6/33 subtests
>
> These all pass on security-next and on v4.11-rc4, so it is definitely
> something in your patches. 
>
>> Patch 01 Adds a smack subdirectory in /proc/.../attr (proposed
>> separately)
>> Patch 02 Move management of the cred blob to the LSM infrastructure.
>> Patch 03 Move management of the file blob to the LSM infrastructure.
>> Patch 04 Change how the security modules get selected.
>> Patch 05 Infrastructure blob management for IPC, keys, sockets.
>> Patch 06 Fixes Smack's sk_free hook.
>> Patch 07 Support mount options for multiple security modules.
>> Patch 08 Change secids from a u32 to a structure.
>> Patch 09 Netlabel consistency enforcment in sendmsg.
>> Patch 10 Fixes a compile issue in one Smack configuration.
>> Patch 11 Infrastructure blob management for the new task blob.
>>
>> These patches can be found in git at:
>>
>> 	https://github.com/cschaufler/smack-next.git#stacking-4.11-rc4
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>
>>  Documentation/security/LSM.txt          |   33 +-
>>  drivers/usb/core/devio.c                |   13 +-
>>  fs/btrfs/super.c                        |   10 +-
>>  fs/proc/base.c                          |   96 ++-
>>  fs/proc/internal.h                      |    1 +
>>  fs/xattr.c                              |    6 +-
>>  include/linux/audit.h                   |   10 +-
>>  include/linux/cred.h                    |    3 +-
>>  include/linux/lsm_hooks.h               |   76 ++-
>>  include/linux/sched/signal.h            |    2 +-
>>  include/linux/security.h                |  227 +++++--
>>  include/net/flow.h                      |    5 +-
>>  include/net/netlabel.h                  |   16 +-
>>  include/net/scm.h                       |    4 +-
>>  kernel/audit.c                          |   25 +-
>>  kernel/audit.h                          |    9 +-
>>  kernel/auditfilter.c                    |    4 +-
>>  kernel/auditsc.c                        |   42 +-
>>  kernel/cred.c                           |   19 +-
>>  kernel/signal.c                         |    6 +-
>>  net/ipv4/cipso_ipv4.c                   |    5 +-
>>  net/ipv4/ip_sockglue.c                  |    6 +-
>>  net/netfilter/nf_conntrack_netlink.c    |   12 +-
>>  net/netfilter/nf_conntrack_standalone.c |    6 +-
>>  net/netfilter/nfnetlink_queue.c         |    9 +-
>>  net/netfilter/xt_AUDIT.c                |    9 +-
>>  net/netfilter/xt_SECMARK.c              |    6 +-
>>  net/netlabel/netlabel_kapi.c            |   56 +-
>>  net/netlabel/netlabel_unlabeled.c       |   30 +-
>>  net/netlabel/netlabel_unlabeled.h       |    2 +-
>>  net/netlabel/netlabel_user.c            |    4 +-
>>  net/unix/af_unix.c                      |    6 +-
>>  net/xfrm/xfrm_policy.c                  |    6 +-
>>  net/xfrm/xfrm_state.c                   |    3 +-
>>  security/Kconfig                        |   86 +++
>>  security/apparmor/context.c             |    2 -
>>  security/apparmor/include/context.h     |   25 +-
>>  security/apparmor/lsm.c                 |  111 ++--
>>  security/integrity/ima/ima_policy.c     |    7 +-
>>  security/security.c                     | 1046
>> +++++++++++++++++++++++++++++--
>>  security/selinux/hooks.c                |  720 +++++++++------------
>>  security/selinux/include/audit.h        |    2 +-
>>  security/selinux/include/objsec.h       |   87 ++-
>>  security/selinux/include/xfrm.h         |    9 +-
>>  security/selinux/netlabel.c             |   17 +-
>>  security/selinux/selinuxfs.c            |    5 +-
>>  security/selinux/ss/services.c          |   13 +-
>>  security/selinux/xfrm.c                 |   29 +-
>>  security/smack/smack.h                  |   95 ++-
>>  security/smack/smack_access.c           |    2 +-
>>  security/smack/smack_lsm.c              |  751 +++++++++----------
>> ---
>>  security/smack/smack_netfilter.c        |   28 +-
>>  security/smack/smackfs.c                |   28 +-
>>  security/tomoyo/common.h                |   25 +-
>>  security/tomoyo/domain.c                |    4 +-
>>  security/tomoyo/securityfs_if.c         |   13 +-
>>  security/tomoyo/tomoyo.c                |   55 +-
>>  57 files changed, 2647 insertions(+), 1280 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
