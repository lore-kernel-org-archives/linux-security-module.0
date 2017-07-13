From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 13 Jul 2017 12:39:10 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <29fdda5e-ed4a-bcda-e3cc-c06ab87973ce@linux.vnet.ibm.com> (Stefan
	Berger's message of "Thu, 13 Jul 2017 13:05:47 -0400")
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com> <20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<29fdda5e-ed4a-bcda-e3cc-c06ab87973ce@linux.vnet.ibm.com>
Message-ID: <8760ew9qyp.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> On 07/13/2017 12:40 PM, Theodore Ts'o wrote:
>> On Thu, Jul 13, 2017 at 07:11:36AM -0500, Eric W. Biederman wrote:
>>> The concise summary:
>>>
>>> Today we have the xattr security.capable that holds a set of
>>> capabilities that an application gains when executed.  AKA setuid root exec
>>> without actually being setuid root.
>>>
>>> User namespaces have the concept of capabilities that are not global but
>>> are limited to their user namespace.  We do not currently have
>>> filesystem support for this concept.
>> So correct me if I am wrong; in general, there will only be one
>> variant of the form:
>>
>>     security.foo at uid=15000
>>
>> It's not like there will be:
>>
>>     security.foo at uid=1000
>>     security.foo at uid=2000
>
> A file shared by 2 containers, one mapping root to uid=1000, the other
> mapping root to uid=2000, will show these two xattrs on the host
> (init_user_ns) once these containers set xattrs on that file.

There is an interesting solution for shared directory trees containing
executables.

Overlayfs is needed if you need those directory trees to be writable and
for the files to show up as owned by uid 0.  An overlayfs will have to
do something with the security.capable attribute.  So ignoring that case.

If you don't care about the ownership of the files, and read only is
acceptable, and you still don't want to give these executables
capabilities in the initial user namespace.  What you can do is
make everything owned by some non-zero uid including the security
capability.  Call this non-zero uid image-root.

When the container starts it creates two nested user namespaces first
with image-root mapped to 0.  Then with the containers choice of uid
mapped to 0 image-root unmapped.  This will ensure the capability
attributes work for all containers that share that root image.  And it
ensures the file are read-only from the container.

So I don't think there is ever a case where we would share a filesystem
image where we would need to set multiple security attributes on a file.

>> Otherwise, I suspect that the architecture is going to turn around and
>> bite us in the *ss eventually, because someone will want to do
>> something crazy and the solution will not be scalable.
>
> Can you define what 'scalable' means for you in this context?
> From what I can see sharing a filesystem between multiple containers
> doesn't 'scale well' for virtualizing the xattrs primarily because of
> size limitations of xattrs per file.

Worse than that I believe you will find that filesystems are built on
the assumption that there will be a small number of xattrs per file.
So even if the vfs limitations were lifted the filesystem performance
would suffer.

Even if the filesystem performed well I believe there are other issues
with stat, and simply not having so much meta-data that adminstrators
and tools get confused.

So I believe there are some very good fundamental reasons why we want to
limit the amount of meta-data per file.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
