From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 18 Apr 2017 16:51:07 +0200
Subject: [PATCH v4 2/6] usb: fix some references for /proc/bus/usb
In-Reply-To: <ba6adfe228123da84ffa3028b71efadd78d483b7.1492389736.git.mchehab@s-opensource.com>
References: <cover.1492389736.git.mchehab@s-opensource.com>
	<ba6adfe228123da84ffa3028b71efadd78d483b7.1492389736.git.mchehab@s-opensource.com>
Message-ID: <20170418145107.GC17714@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Apr 16, 2017 at 09:51:07PM -0300, Mauro Carvalho Chehab wrote:
> Since when we got rid of usbfs, the /proc/bus/usb is now
> elsewhere. Fix references for it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Oops, will take this one instead...
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
