From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 18 Jul 2017 08:26:37 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <aae67245-4c9c-f79e-b821-40753e732f65@linux.vnet.ibm.com> (Stefan
	Berger's message of "Tue, 18 Jul 2017 08:12:13 -0400")
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com> <20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<29fdda5e-ed4a-bcda-e3cc-c06ab87973ce@linux.vnet.ibm.com>
	<alpine.LRH.2.20.1707181659030.5209@namei.org>
	<aae67245-4c9c-f79e-b821-40753e732f65@linux.vnet.ibm.com>
Message-ID: <871spdj2pe.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> On 07/18/2017 03:01 AM, James Morris wrote:
>> On Thu, 13 Jul 2017, Stefan Berger wrote:
>>
>>> A file shared by 2 containers, one mapping root to uid=1000, the other mapping
>>> root to uid=2000, will show these two xattrs on the host (init_user_ns) once
>>> these containers set xattrs on that file.
>> I may be missing something here, but what happens when say the uid=2000
>> container and associated user is deleted from the system, then another is
>> created with the same uid?
>>
>> Won't this mean that you have unexpected capabilities turning up in the
>> new container?
>>
>
> Yes, that's right. I don't know any solution for that. We would have to walk the
> filesystems and find all 'stale' xattrs with such a uid. This is independent of
> whether the uid is encoded on the name side, as in this patch, or on the value
> side, as in Serge's original proposal. And uids of a mapped container root user
> don't necessarily have to have an account on the host so that an account
> deletion could trigger that.

This problem is actually independent of this piece of code entirely.
Any lingering files owned by that uid have the same issue.

Uids are are persistent system property.  It must be arranged that they
are managed carefully.  If you want to reuse a uid userdel or the
equivalent must be able to go out and delete everything they have owned.

Which is to say fundamentally this is userspaces's responsibility.

I don't see this as being particularly subtle or novel.  We already
track which uids and which subordinate uids go together.  I will nack
anything that allows multiple capability attributes per file as we have
established they are unnecessary.  So I don't see any scenarios where
this is likely to come up that it would not be a problem without these
uid tagged security capabilities.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
