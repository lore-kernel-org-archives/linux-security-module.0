From: dhowells@redhat.com (David Howells)
Date: Tue, 10 Apr 2018 09:47:00 +0100
Subject: [PATCH] uapi/linux/keyctl.h: don't use C++ reserved keyword as a
	struct member name
In-Reply-To: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
References: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
Message-ID: <19745.1523350020@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> Since this header is in "include/uapi/linux/", apparently people
> want to use it in userspace programs -- even in C++ ones.
> However, the header uses a C++ reserved keyword ("private"),
> so change that to "dh_private" instead to allow the header file
> to be used in C++ userspace.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=191051

Ugh.  Yeah.  This is a UAPI breaker, but I think we have to do it, despite it
being 2 years old.  Maybe wrap that element in a #ifdef so it's still allowed
in C?

cc'ing Mat Martineau as he's the originator of the structure.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
