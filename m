From: ananth@linux.vnet.ibm.com (Ananth N Mavinakayanahalli)
Date: Wed, 8 Nov 2017 22:01:48 +0530
Subject: [RFC][PATCH] Lock down kprobes
In-Reply-To: <14323.1510158093@warthog.procyon.org.uk>
References: <14323.1510158093@warthog.procyon.org.uk>
Message-ID: <20171108163148.GA8882@in.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 08, 2017 at 04:21:33PM +0000, David Howells wrote:
> Hi,
> 
> I need to lock down kprobes under secure boot conditions as part of the patch
> series that can be found here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=efi-lock-down
> 
> Can you tell me that if the attached patch is sufficient to the cause?

This will not prevent the raw kprobe events from working. If your
intention is to prevent *any* kprobe registration, the best place to do
that is in register_kprobe() in kernel/probes.c

Ananth

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
