From: dhowells@redhat.com (David Howells)
Date: Tue, 06 Jun 2017 10:34:51 +0100
Subject: [PATCH 0/5] security, efi: Set lockdown if in secure boot mode
In-Reply-To: <CAKv+Gu_vXASr=yDJ3MwT960eApqeWKEd-hqGoEyGsJKip7N+KQ@mail.gmail.com>
References: <CAKv+Gu_vXASr=yDJ3MwT960eApqeWKEd-hqGoEyGsJKip7N+KQ@mail.gmail.com>
	<149563711758.9419.11406612723056598045.stgit@warthog.procyon.org.uk>
	<CAKv+Gu_5gUWwx7Sxgm8d03L4t4nF8dDe+AXqOqto4B7AVSZ9CA@mail.gmail.com>
	<21606.1496222635@warthog.procyon.org.uk>
Message-ID: <25009.1496741691@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> and print a subsequent line for every lockdown feature that is enabled, e.g.,
> 
> lockdown: disabling MSRs
> lockdown: disabling hibernate support

There's another problem with this idea: the lockdown facility is passive - it
doesn't go looking for things to lock down; rather, things that can be locked
down inquire as to whether lockdown is in effect at the point someone tries to
use them.

Now, I could reserve a variable for each thing we lock down to make sure that
we don't emit the message more than once, but I'm loathe to waste memory this
way.

I can't so easily switch the facility to being active either, since a lot of
the lockdownables are in modules.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
