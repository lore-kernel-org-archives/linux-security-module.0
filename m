From: dhowells@redhat.com (David Howells)
Date: Wed, 05 Apr 2017 15:33:00 +0100
Subject: [PATCH 27/39] Annotate hardware config module parameters in
	drivers/scsi/
In-Reply-To: <alpine.LNX.2.00.1612020903450.24840@nippy.intranet>
References: <alpine.LNX.2.00.1612020903450.24840@nippy.intranet>
	<148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
	<148059559339.31612.16180464424786438715.stgit@warthog.procyon.org.uk>
Message-ID: <24495.1491402780@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Finn Thain <fthain@telegraphics.com.au> wrote:

> I can see how base addresses and IO ports are relevant, but the irq 
> parameter changes below don't protect the kernel image AFAICT. What's the 
> rationale for those changes? I think it should be stated here.

Easier grepping for one.  But I'm also currently preventing the changing of
any hardware parameters.  If a driver refuses to share an irq, you could use
it to deprive another driver of the ability to get an irq at all.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
