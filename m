From: dhowells@redhat.com (David Howells)
Date: Thu, 05 Oct 2017 14:20:00 +0100
Subject: Draft manpage explaining kernel lockdown
In-Reply-To: <3765ad08-2c73-7285-02e1-e04f31dde3fd@redhat.com>
References: <3765ad08-2c73-7285-02e1-e04f31dde3fd@redhat.com>
	<7969.1507201224@warthog.procyon.org.uk>
Message-ID: <9488.1507209600@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Florian Weimer <fweimer@redhat.com> wrote:

> > Lockdown is typically enabled during boot and may be terminated, if
> > configured, by typing a special key combination on a directly attached
> > physical keyboard.
> 
> Does this include a Bluetooth keyboard (which might not actually exist and
> might in reality be another server in the same rack, of course).

Ummm...  Interesting question.  I'm not sure how to tell.  I think it
shouldn't include a Bluetooth keyboard, and not even a serial console.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
