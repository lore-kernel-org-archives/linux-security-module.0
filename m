From: dhowells@redhat.com (David Howells)
Date: Mon, 24 Sep 2018 13:00:20 +0100
Subject: [PATCH] Revert "uapi/linux/keyctl.h: don't use C++ reserved
	keyword as a struct member name"
In-Reply-To: <20180924094723.487697-1-lkundrak@v3.sk>
References: <20180924094723.487697-1-lkundrak@v3.sk>
Message-ID: <26184.1537790420@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> wrote:

> This changes UAPI, breaking iwd and libell:
> 
>   ell/key.c: In function 'kernel_dh_compute':
>   ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member named 'private'; did you mean 'dh_private'?
>     struct keyctl_dh_params params = { .private = private,
>                                         ^~~~~~~
>                                         dh_private
> 
> This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: <stable@vger.kernel.org>

Can I stick your Signed-off-by on it?

David
