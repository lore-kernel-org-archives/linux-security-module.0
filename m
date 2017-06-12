From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 12 Jun 2017 21:38:26 +0200
Subject: [PATCH 03/11] Creation of "usb_device_auth" LSM hook
In-Reply-To: <1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <20170612193826.GA4235@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jun 12, 2017 at 06:56:52PM +0200, Salvatore Mesoraca wrote:
> Creation of a new LSM hook that can be used to authorize or deauthorize
> new USB devices via the usb authorization interface.
> The same hook can also prevent the authorization of a USB device via
> "/sys/bus/usb/devices/DEVICE/authorized".
> Using this hook an LSM could provide an higher level of granularity
> than the current authorization interface.
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> Cc: linux-usb at vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

No, like Krzysztof said, you can already do this today, just fine, from
userspace.  I think that support has been there for over a decade now,
why are you not taking advantage of this already?

No need to add extra stuff to the kernel at all to do this, sorry you
implemented all of this for no reason :(

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
