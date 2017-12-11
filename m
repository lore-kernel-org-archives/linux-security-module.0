From: sgrubb@redhat.com (Steve Grubb)
Date: Mon, 11 Dec 2017 10:35:58 -0500
Subject: Unique audit record type ranges for individual LSMs
In-Reply-To: <4491cccc-9219-f653-0c1d-f8dd6612f0f1@canonical.com>
References: <4491cccc-9219-f653-0c1d-f8dd6612f0f1@canonical.com>
Message-ID: <6551315.ApPrxtqdP3@x2>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wednesday, December 6, 2017 12:51:26 PM EST Tyler Hicks wrote:
> Hello - The AppArmor project would like for AppArmor audit records to be
> supported by the audit-userspace tools, such as ausearch, but it
> requires some coordination between the linux-security-module and
> linux-audit lists. This was raised as a feature request years ago in
> Ubuntu and more recently in Debian:
> 
>   https://launchpad.net/bugs/1117804
>   https://bugs.debian.org/872726
> 
> The quick summary of the problem at hand is that the audit-userspace
> project requires that each LSM use a unique record type range for audit
> records while the kernel's common_lsm_audit() function uses the same
> record type (1400) for all records. SELinux, AppArmor, and SMACK are all
> using common_lsm_audit() today and, therefore, the 1400-1499 range.
> 
> While it will be potentially painful to switch, the AppArmor project is
> considering to use a unique range in order for audit-userspace to
> support AppArmor audit records. IMHO, SMACK would be free to continue
> using 1400-1499 as long as they don't need audit-userspace support and
> SELinux would continue using 1400-1499.
> 
> Steve Grubb previously told me that he intends 1500-1599 to be used by
> AppArmor:
> 
>   https://www.redhat.com/archives/linux-audit/2014-May/msg00119.html
> 
> 
> John Johansen tells me that AppArmor previously used the 1500-1599 range
> before AppArmor was upstreamed.

Yes, this is what I have:

#define AUDIT_AA                        1500    /* Not upstream yet */
#define AUDIT_APPARMOR_AUDIT            1501
#define AUDIT_APPARMOR_ALLOWED          1502
#define AUDIT_APPARMOR_DENIED           1503
#define AUDIT_APPARMOR_HINT             1504
#define AUDIT_APPARMOR_STATUS           1505
#define AUDIT_APPARMOR_ERROR            1506


> There's a conflicting comment in the kernel stating that 1500-1599 is to
> by used by kernel LSPP events. As far as I can tell, there were never
> any kernel LSPP events that used the range.

This seems like an erroneous comment in audit.h.


> Steve is the one that added that comment so I think it is a safe range for
> AppArmor to use:
> 
>   https://git.kernel.org/linus/90d526c074ae5db484388da56c399acf892b6c17

I think this commit predates the agreement on the apparmor range and a 
followup assignment in the kernel was never done.


> Considering audit-userspace's stance, does the LSM community agree that
> common_lsm_audit() should be modified to accept an audit record type
> parameter to pass on to audit_log_start()?

This is part of the problem. I get an AVC from selinux like this:

type=AVC msg=audit(1512997597.761:271): avc:  denied  { append } for  pid=1304 
comm="mail" name="dead.letter" dev="nvme0n1p2" ino=17 
scontext=system_u:system_r:fsdaemon_t:s0 
tcontext=system_u:object_r:etc_runtime_t:s0 tclass=file permissive=0

Nowhere in this does it tell me this is from the selinux LSM. So, that means 
it is implicit in the event number. Its important for me to know what LSM sent 
this so that it can be parsed correctly. If every LSM uses the same event 
numbers as selinux, then we probably have parsing problems because they are 
being parsed like selinux events and the wording/reporting probably does not 
make sense.


> If so, does everyone agree that 1500-1599 would be acceptable for
> AppArmor to use?

In the absence of any way to determine what I'm dealing with, separating LSMs 
by event number is best.

Also, I don't get or see any events from these other LSM's. I can't reproduce 
any bugs or verify the correctness of any reports or searches. Not that I 
don't want to support other LSM's, but I need someone else to check it and 
make sure it's doing  the right thing. Patches are welcome.

-Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
