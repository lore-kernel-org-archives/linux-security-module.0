From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Fri, 14 Jul 2017 08:39:49 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <87vamv2pj0.fsf@xmission.com>
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
	<65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
	<87vamv2pj0.fsf@xmission.com>
Message-ID: <6eb8226e-58b7-88cc-a8e4-35df47ae5688@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/14/2017 08:04 AM, Eric W. Biederman wrote:
> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
>
>> On 07/13/2017 08:38 PM, Eric W. Biederman wrote:
>>> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
>>>
>>>> On 07/13/2017 01:49 PM, Eric W. Biederman wrote:
>>>>
>>>>> My big question right now is can you implement Ted's suggested
>>>>> restriction.  Only one security.foo or secuirty.foo at ... attribute ?
>>>> We need to raw-list the xattrs and do the check before writing them. I am fairly sure this can be done.
>>>>
>>>> So now you want to allow security.foo and one security.foo at uid=<> or just a single one security.foo(@[[:print:]]*)?
>>>>
>>> The latter.
>> That case would prevent a container user from overriding the xattr on
>> the host. Is that what we want?
> Most definitely.  If a more privileged use has set secure.capable that
> is better.
>
>> For limiting the number of xattrs and
>> getting that functionality (override IMA signature for example) the
>> former seems better...
> I don't know about IMA.  But my feeling is that we will only be dealing
> with a single signing key, so I don't see how having multiple IMA xattrs
> make sense.  Could you explain that to me?

Admittedly I would need to construct and example where the user inside 
the container doesn't want to share the public key with the host on a 
file mounted from the host for some reason.

An example related to security.capability could be a Fedora Docker 
container where the container is distributed with the ping tool 
installed. The ping tool is installed with cap_net_admin,cap_net_raw+ep. 
On a normal Fedora container I cannot use this tool due to my 
capabilities bounding set not including cap_net_admin. So, I overwrite 
this and set only cap_net_raw+ep and I can use for pinging. I may loose 
some functionality on the way due to the lost cap_net_admin but I can 
now use the tool. I guess the point is one can override the capabilities 
set of a distributed container if the container is started with less 
capabilities.

    Stefan


>
>> For the former I now have the topmost patch here:
>> https://github.com/stefanberger/linux/commits/xattr_for_userns.v3
> Thank you.
>
> Eric
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
