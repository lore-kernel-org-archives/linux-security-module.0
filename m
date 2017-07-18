From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 18 Jul 2017 08:12:13 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <alpine.LRH.2.20.1707181659030.5209@namei.org>
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
Message-ID: <aae67245-4c9c-f79e-b821-40753e732f65@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/18/2017 03:01 AM, James Morris wrote:
> On Thu, 13 Jul 2017, Stefan Berger wrote:
>
>> A file shared by 2 containers, one mapping root to uid=1000, the other mapping
>> root to uid=2000, will show these two xattrs on the host (init_user_ns) once
>> these containers set xattrs on that file.
> I may be missing something here, but what happens when say the uid=2000
> container and associated user is deleted from the system, then another is
> created with the same uid?
>
> Won't this mean that you have unexpected capabilities turning up in the
> new container?
>

Yes, that's right. I don't know any solution for that. We would have to 
walk the filesystems and find all 'stale' xattrs with such a uid. This 
is independent of whether the uid is encoded on the name side, as in 
this patch, or on the value side, as in Serge's original proposal. And 
uids of a mapped container root user don't necessarily have to have an 
account on the host so that an account deletion could trigger that.

     Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
