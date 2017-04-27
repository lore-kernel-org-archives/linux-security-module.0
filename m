From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Thu, 27 Apr 2017 15:06:34 -0400
Subject: [PATCH v4 3/4] KEYS: Support for inserting a certificate into x86
	bzImage
In-Reply-To: <13470.1493301291@warthog.procyon.org.uk>
References: <1492727320-26194-4-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<1492727320-26194-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
	<13470.1493301291@warthog.procyon.org.uk>
Message-ID: <73122870-E138-4DA5-90C9-91CB664E7DF1@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> On Apr 27, 2017, at 9:54 AM, David Howells <dhowells@redhat.com> wrote:
> 
> Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com> wrote:
> 
>> +	/* TODO: update CRC */
> 
> Is this bit missing?

I didn't add it, since I wasn't sure it was still used with secure boot. The CRC 
code is implemented in multiple places, but not exposed to the tools/scripts.
Should I make the crc32() in tools/pcmcia/crc32hash.c non-static, maybe?

Mehmet 


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
