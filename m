From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 6 Dec 2017 10:47:43 -0800
Subject: Unique audit record type ranges for individual LSMs
In-Reply-To: <4491cccc-9219-f653-0c1d-f8dd6612f0f1@canonical.com>
References: <4491cccc-9219-f653-0c1d-f8dd6612f0f1@canonical.com>
Message-ID: <3ea79b60-21cb-5638-304d-97bde8b12b5c@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 12/6/2017 9:51 AM, Tyler Hicks wrote:
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

My, but this is a rat's nest, isn't it? The constants, such as AUDIT_MAC_STATUS,
look as if they are intended to be generic. But the comment says the range is
for SELinux. Some of the events, including AUDIT_MAC_MAP_ADD *are* generic, in
that they are from the netlbl subsystem. But some, AUDIT_AVC being paramount,
are indeed SELinux specific.

> While it will be potentially painful to switch, the AppArmor project is
> considering to use a unique range in order for audit-userspace to
> support AppArmor audit records. IMHO, SMACK would be free to continue
> using 1400-1499 as long as they don't need audit-userspace support and
> SELinux would continue using 1400-1499.

Aside from the comment that says 1400-1499 are for SELinux, and the three
events (1400-1402) that are SELinux specific, the events really are general.
Why not add the AppArmor specifics to the 1400 range? Give them a generic
sounding name and you'll achieve consistency. Change the comment to say
"Security Module use" instead of "SELinux use".

> Steve Grubb previously told me that he intends 1500-1599 to be used by
> AppArmor:
>
>   https://www.redhat.com/archives/linux-audit/2014-May/msg00119.html
>
>
> John Johansen tells me that AppArmor previously used the 1500-1599 range
> before AppArmor was upstreamed.
>
> There's a conflicting comment in the kernel stating that 1500-1599 is to
> by used by kernel LSPP events. As far as I can tell, there were never
> any kernel LSPP events that used the range. Steve is the one that added
> that comment so I think it is a safe range for AppArmor to use:
>
>   https://git.kernel.org/linus/90d526c074ae5db484388da56c399acf892b6c17
>
> Considering audit-userspace's stance, does the LSM community agree that
> common_lsm_audit() should be modified to accept an audit record type
> parameter to pass on to audit_log_start()?
>
> If so, does everyone agree that 1500-1599 would be acceptable for
> AppArmor to use?

Why not change the comment and continue to use the 1400 range, adding
events as necessary?

>
> Tyler
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
