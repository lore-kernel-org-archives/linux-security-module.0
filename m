From: sgrubb@redhat.com (Steve Grubb)
Date: Mon, 11 Dec 2017 10:44:22 -0500
Subject: Unique audit record type ranges for individual LSMs
In-Reply-To: <3ea79b60-21cb-5638-304d-97bde8b12b5c@schaufler-ca.com>
References: <4491cccc-9219-f653-0c1d-f8dd6612f0f1@canonical.com>
	<3ea79b60-21cb-5638-304d-97bde8b12b5c@schaufler-ca.com>
Message-ID: <9007498.tkJPu7STvn@x2>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wednesday, December 6, 2017 1:47:43 PM EST Casey Schaufler wrote:
> > While it will be potentially painful to switch, the AppArmor project is
> > considering to use a unique range in order for audit-userspace to
> > support AppArmor audit records. IMHO, SMACK would be free to continue
> > using 1400-1499 as long as they don't need audit-userspace support and
> > SELinux would continue using 1400-1499.
> 
> Aside from the comment that says 1400-1499 are for SELinux, and the three
> events (1400-1402) that are SELinux specific, the events really are general.
> Why not add the AppArmor specifics to the 1400 range? Give them a generic
> sounding name and you'll achieve consistency. Change the comment to say
> "Security Module use" instead of "SELinux use".

I really don't know what the status is for user space support on the other 
LSMs. I couldn't tell you if the searching/reporting are broken or working 
just fine.

Additionally, there is auditctl which has very selinux specific field options 
to audit on a variety of pieces of the labels. Does this make sense for other 
LSMs? Do other LSMs have different needs? I really have no idea.

But one thing for sure...if we combine them all, I expect patches are needed 
for user space. By separating them out by event number or some identifier like 
lsm=, then we can have lsm specific fixups if necessary.

-Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
