From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 6 Apr 2017 22:09:47 +0200
Subject: [PATCH 11/24] uswsusp: Disable when the kernel is locked down
In-Reply-To: <14980.1491468060@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142336965.5101.2946578135980499557.stgit@warthog.procyon.org.uk>
	<CAJZ5v0hp=GJtQ+YnNdaMw6rtbBzNyueY+iqjPkHLKp57t822ZQ@mail.gmail.com>
	<1491460792.1645.1.camel@suse.com>
	<14980.1491468060@warthog.procyon.org.uk>
Message-ID: <CAJZ5v0gFeF3hdr0QzUeaT2dS+HhG7KUdVPPWHKeqHVkX78s+Tw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Apr 6, 2017 at 10:41 AM, David Howells <dhowells@redhat.com> wrote:
> Oliver Neukum <oneukum@suse.com> wrote:
>
>> Your swap partition may be located on an NVDIMM or be encrypted.
>
> An NVDIMM should be considered the same as any other persistent storage.
>
> It may be encrypted, but where's the key stored, how easy is it to retrieve
> and does the swapout code know this?
>
>> Isn't this a bit overly drastic?
>
> Perhaps, but if it's on disk and it's not encrypted, then maybe not.

Right.

Swap encryption is not mandatory and I'm not sure how the hibernate
code can verify whether or not it is in use.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
