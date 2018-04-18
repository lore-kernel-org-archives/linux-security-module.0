From: john.johansen@canonical.com (John Johansen)
Date: Wed, 18 Apr 2018 09:09:23 -0700
Subject: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
In-Reply-To: <1523636702.3272.63.camel@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87sh8lcecn.fsf@xmission.com>
	<1523636702.3272.63.camel@linux.vnet.ibm.com>
Message-ID: <d8c30d7d-c679-9323-7a25-d3148e9b96c6@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/13/2018 09:25 AM, Mimi Zohar wrote:
> [Cc'ing John Johansen]
> 
> On Tue, 2018-03-27 at 18:01 -0500, Eric W. Biederman wrote:
> [...]
>> As such I expect the best way to create the ima namespace is by simply
>> writing to securityfs/imafs.  Possibly before the user namespace is
>> even unshared.  That would allow IMA to keep track of things from
>> before a container is created.
> 

I do think this is generally the right approach for LSMs when looking
forward to LSM stacking and more LSMs.


> My initial thought was to stage IMA namespacing with just IMA-audit
> first, followed by either IMA-measurement or IMA-appraisal. ?This
> would allow us to get the basic IMA namespacing framework working and
> defer dealing with the securityfs related namespacing of the IMA
> policy and measurement list issues to later.
> 
> By tying IMA namespacing to a securityfs ima/unshare file, we would
> need to address the securityfs issues first.
> 

well it depends on what you want to do. It would be possible to have
a simple file (not a jump link) within securityfs that IMA could use
without having to deal with all the securityfs issues first. However it
does require that securityfs (not necessarily imafs) be visible within
the mount namespace of the task doing the setup.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
