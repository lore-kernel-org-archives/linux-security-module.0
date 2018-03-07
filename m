From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Wed, 7 Mar 2018 23:17:46 +0530
Subject: [PATCH 1/3] certs: define a trusted platform keyring
In-Reply-To: <31489.1520438598@warthog.procyon.org.uk>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
	<31489.1520438598@warthog.procyon.org.uk>
Message-ID: <8873df7f-490f-28e0-249e-34bb3b133015@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 03/07/2018 09:33 PM, David Howells wrote:
> Nayna Jain <nayna@linux.vnet.ibm.com> wrote:
>
>> +		key = key_create_or_update(make_key_ref(keyring, 1),
>> +				"asymmetric",
>> +				NULL,
>> +				p,
>> +				plen,
>> +				((KEY_POS_ALL & ~KEY_POS_SETATTR) |
>> +				 KEY_USR_VIEW | KEY_USR_READ),
>> +				KEY_ALLOC_NOT_IN_QUOTA |
>> +				KEY_ALLOC_BUILT_IN |
>> +				KEY_ALLOC_BYPASS_RESTRICTION);
> There's no need to reindent here.  Please line up all the arguments: either
> push the first argument over onto the next line if you need to or line them
> all up with the char after the opening bracket.

Thanks David for the feedback. I will post the v2 version with this fix. 
Are there any other changes ?

Thanks & Regards,
 ?? - Nayna

>
> David
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
