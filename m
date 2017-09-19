From: dhowells@redhat.com (David Howells)
Date: Tue, 19 Sep 2017 17:05:20 +0100
Subject: [PATCH] KEYS: prevent creating a different user's keyrings
In-Reply-To: <20170918183703.114134-1-ebiggers3@gmail.com>
References: <20170918183703.114134-1-ebiggers3@gmail.com>
Message-ID: <29684.1505837120@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Fix it by marking user and user session keyrings with a flag
> KEY_FLAG_UID_KEYRING.  Then, when searching for a user or user session
> keyring by name, skip all keyrings that don't have the flag set.

I wonder if it's better just to reject attempts to manually create/join
keyrings of such names.  PAM uses the implicit creation method of specifying
the 'macro' key IDs for these keyrings.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
