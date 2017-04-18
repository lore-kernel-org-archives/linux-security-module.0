From: Jens.Rottmann@ADLINKtech.com (Jens Rottmann)
Date: Tue, 18 Apr 2017 18:34:17 +0200
Subject: [PATCH 06/38] Annotate hardware config module parameters in
	drivers/clocksource/
In-Reply-To: <alpine.DEB.2.20.1704142021320.2327@nanos>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141145858.29162.13072730133817038218.stgit@warthog.procyon.org.uk>
	<alpine.DEB.2.20.1704142021320.2327@nanos>
Message-ID: <9f97544c-cb49-c2a3-ecec-7840386d9281@ADLINKtech.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/15/2017 00:59, David Howells wrote:
> When the kernel is running in secure boot mode [...] prevent
> access by means of configuring driver modules

I may easily be wrong, but doesn't secure boot require EFI? Do secure
boot capable systems with old CS5535/36 even exist?

Thanks,
Jens
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
