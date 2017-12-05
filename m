From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 5 Dec 2017 14:34:06 +0100
Subject: [PATCH] security: Export few symbols referred by other modules
In-Reply-To: <alpine.LFD.2.20.1712052259390.14735@localhost>
References: <1512471537-23865-1-git-send-email-hareeshg@codeaurora.org>
	<alpine.LFD.2.20.1712052259390.14735@localhost>
Message-ID: <20171205133406.GD13746@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Dec 05, 2017 at 11:04:35PM +1100, James Morris wrote:
> On Tue, 5 Dec 2017, Hareesh Gundu wrote:
> 
> > Export mmap_min_addr and security_mmap_addr() to allow
> > kernel modules to use them.

What in-tree kernel module needs these symbols?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
