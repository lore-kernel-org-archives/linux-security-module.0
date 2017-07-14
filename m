From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Fri, 14 Jul 2017 07:32:42 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <87h8yf7szd.fsf@xmission.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com> <20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<87k23cb6os.fsf@xmission.com>
	<847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
	<87bmoo8bxb.fsf@xmission.com>
	<9a3010e5-ca2b-5e7a-656b-fcc14f7bec4e@linux.vnet.ibm.com>
	<87h8yf7szd.fsf@xmission.com>
Message-ID: <65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/13/2017 08:38 PM, Eric W. Biederman wrote:
> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
>
>> On 07/13/2017 01:49 PM, Eric W. Biederman wrote:
>>
>>> My big question right now is can you implement Ted's suggested
>>> restriction.  Only one security.foo or secuirty.foo at ... attribute ?
>> We need to raw-list the xattrs and do the check before writing them. I am fairly sure this can be done.
>>
>> So now you want to allow security.foo and one security.foo at uid=<> or just a single one security.foo(@[[:print:]]*)?
>>
> The latter.

That case would prevent a container user from overriding the xattr on 
the host. Is that what we want? For limiting the number of xattrs and 
getting that functionality (override IMA signature for example) the 
former seems better...

For the former I now have the topmost patch here: 
https://github.com/stefanberger/linux/commits/xattr_for_userns.v3

    Stefan


>
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
