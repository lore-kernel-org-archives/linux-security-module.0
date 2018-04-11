From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 11 Apr 2018 10:26:12 -0700
Subject: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked
	down
In-Reply-To: <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
	<152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
Message-ID: <65f9440e-64f6-d573-62a1-f2295cb92c61@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/11/2018 09:27 AM, David Howells wrote:

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> cc: acpi4asus-user at lists.sourceforge.net
> cc: platform-driver-x86 at vger.kernel.org
> cc: Matthew Garrett <mjg59@srcf.ucam.org>
> cc: Thomas Gleixner <tglx@linutronix.de>
> ---
meta-comment:

I have been dinged for not spelling "cc:" as "Cc:". I really think that
either way should be acceptable.

-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
