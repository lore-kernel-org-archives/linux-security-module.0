From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Fri, 14 Jul 2017 11:22:28 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <20170714133437.GA16737@mail.hallyn.com>
References: <74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<87k23cb6os.fsf@xmission.com>
	<847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
	<87bmoo8bxb.fsf@xmission.com>
	<9a3010e5-ca2b-5e7a-656b-fcc14f7bec4e@linux.vnet.ibm.com>
	<87h8yf7szd.fsf@xmission.com>
	<65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
	<20170714133437.GA16737@mail.hallyn.com>
Message-ID: <596f808b-e21d-8296-5fef-23c1ce7ab778@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/14/2017 09:34 AM, Serge E. Hallyn wrote:
> Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
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
>> That case would prevent a container user from overriding the xattr
>> on the host. Is that what we want? For limiting the number of xattrs
> Not really.  If the file is owned by a uid mapped into the container,
> then the container root can chown the file which will clear the file
> capability, after which he can set a new one.  If the file is not
> owned by a uid mapped into the container, then container root could
> not set a filecap anyway.

Let's say I installed a container where all files are signed and thus 
have security.ima. Now for some reason I want to re-sign some or all 
files inside that container. How would I do that ? Would I need to get 
rid of security.ima first, possibly by copying each file, deleting the 
original file, and renaming the copied file to the original name, or 
should I just be able to write out a new signature, thus creating 
security.ima at uid=1000 besides the security.ima ?

    Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
