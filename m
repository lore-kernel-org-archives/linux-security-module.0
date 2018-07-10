From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 10 Jul 2018 16:28:30 -0700
Subject: [PATCH 08/32] smack: Implement filesystem context security hooks
	[ver #9]
In-Reply-To: <16480.1531264793@warthog.procyon.org.uk>
References: <dc5039cb-97cf-fe72-d601-f48eb26e8e66@schaufler-ca.com>
	<153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
	<153126254346.14533.14191961720018099798.stgit@warthog.procyon.org.uk>
	<16480.1531264793@warthog.procyon.org.uk>
Message-ID: <27bf0500-470d-d68a-2757-25cfae05d5a0@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 7/10/2018 4:19 PM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>> Implement filesystem context security hooks for the smack LSM.
>>>
>>> Question: Should the ->fs_context_parse_source() hook be implemented to
>>> check the labels on any source devices specified?
>> Checking the label on a block device when doing a mount
>> is just going to end in tears. If you're remounting from
>> an already mounted filesystem it might make sense to check
>> that the new mount doesn't provide greater access than the
>> existing mount. If the original mount has smackfsdefault="_"
>> I could see prohibiting the additional mount having
>> smackfsdefault="*" on a filesystem that doesn't support
>> xattrs. But that requires that a (hopefully) privileged
>> process be involved, and we expect them to have a clue.
>> So no, I don't see it necessary.
> I think I may have meant the device file rather than the actual device
> content.

You may have! I see no reason to look at the label on /dev/sdb1
when mounting it. There's already sufficient privilege required
to protect that in my mind.

>
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
