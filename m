From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 13 Apr 2018 12:25:02 -0400
Subject: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
In-Reply-To: <87sh8lcecn.fsf@xmission.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87sh8lcecn.fsf@xmission.com>
Message-ID: <1523636702.3272.63.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[Cc'ing John Johansen]

On Tue, 2018-03-27 at 18:01 -0500, Eric W. Biederman wrote:
[...]
> As such I expect the best way to create the ima namespace is by simply
> writing to securityfs/imafs.  Possibly before the user namespace is
> even unshared.  That would allow IMA to keep track of things from
> before a container is created.

My initial thought was to stage IMA namespacing with just IMA-audit
first, followed by either IMA-measurement or IMA-appraisal. ?This
would allow us to get the basic IMA namespacing framework working and
defer dealing with the securityfs related namespacing of the IMA
policy and measurement list issues to later.

By tying IMA namespacing to a securityfs ima/unshare file, we would
need to address the securityfs issues first.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
