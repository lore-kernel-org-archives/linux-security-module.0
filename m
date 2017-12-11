From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 11 Dec 2017 12:56:35 -0800
Subject: Unique audit record type ranges for individual LSMs
In-Reply-To: <9007498.tkJPu7STvn@x2>
References: <4491cccc-9219-f653-0c1d-f8dd6612f0f1@canonical.com>
	<3ea79b60-21cb-5638-304d-97bde8b12b5c@schaufler-ca.com>
	<9007498.tkJPu7STvn@x2>
Message-ID: <0c983dbd-ead2-523c-e6d5-6b52231e33cf@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 12/11/2017 7:44 AM, Steve Grubb wrote:
> On Wednesday, December 6, 2017 1:47:43 PM EST Casey Schaufler wrote:
>>> While it will be potentially painful to switch, the AppArmor project is
>>> considering to use a unique range in order for audit-userspace to
>>> support AppArmor audit records. IMHO, SMACK would be free to continue
>>> using 1400-1499 as long as they don't need audit-userspace support and
>>> SELinux would continue using 1400-1499.
>> Aside from the comment that says 1400-1499 are for SELinux, and the three
>> events (1400-1402) that are SELinux specific, the events really are general.
>> Why not add the AppArmor specifics to the 1400 range? Give them a generic
>> sounding name and you'll achieve consistency. Change the comment to say
>> "Security Module use" instead of "SELinux use".
> I really don't know what the status is for user space support on the other 
> LSMs. I couldn't tell you if the searching/reporting are broken or working 
> just fine.

Understood. And it's only going to get worse with module stacking.

> Additionally, there is auditctl which has very selinux specific field options 
> to audit on a variety of pieces of the labels. Does this make sense for other 
> LSMs? Do other LSMs have different needs? I really have no idea.

Three of the record types are SELinux specific. Nine are netlabel, which are
not SELinux specific, or at least shouldn't be. Three are about setting state.
We could have different audit records for Smack setting netlabel maps from the
one SELinux uses, but that seems wrong.

> But one thing for sure...if we combine them all, I expect patches are needed 
> for user space. By separating them out by event number or some identifier like 
> lsm=, then we can have lsm specific fixups if necessary.

It seems to me that adding proper support for security modules
other than SELinux is going to be a project. That's true regardless
of how the messages are numbered and whether or not we have generic
messages.

> -Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
