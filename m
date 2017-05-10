From: danielmicay@gmail.com (Daniel Micay)
Date: Wed, 10 May 2017 17:02:14 -0400
Subject: [kernel-hardening] Re: [PATCH v6 0/2] security: tty: make
	TIOCSTI ioctl require CAP_SYS_ADMIN
In-Reply-To: <20170510212920.7f6bc5e6@alans-desktop>
References: <20170505232018.28846-1-matt@nmatt.com>
	<20170510212920.7f6bc5e6@alans-desktop>
Message-ID: <1494450134.28559.2.camel@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-05-10 at 21:29 +0100, Alan Cox wrote:
> 
> In addition your change to allow it to be used by root in the guest
> completely invalidates any protection you have because I can push
> 
> "rm -rf /\n"
> 
> as root in my namespace and exit
> 
> The tty buffers are not flushed across the context change so the shell
> you return to gets the input and oh dear....
> 
> Alan

I might be missing something, but it looks like the patch tracks where
the tty was created and only allows this with CAP_SYS_ADMIN in the ns
where the tty came from.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
