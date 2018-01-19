From: git@andred.net (=?ISO-8859-1?Q?Andr=E9?= Draszik)
Date: Fri, 19 Jan 2018 09:16:53 +0000
Subject: [PATCH 3/3] encrypted-keys: document new fscrypt key format
In-Reply-To: <20180117180537.GB6948@thunk.org>
References: <20180110124418.24385-1-git@andred.net>
	<20180110124418.24385-3-git@andred.net>
	<20180111044801.GB943@zzz.localdomain>
	<1516199939.28972.101.camel@andred.net>
	<20180117180537.GB6948@thunk.org>
Message-ID: <1516353413.28972.119.camel@andred.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Thank you Ted,

On Wed, 2018-01-17 at 13:05 -0500, Theodore Ts'o wrote:
> On Wed, Jan 17, 2018 at 02:38:59PM +0000, Andr? Draszik wrote:
> > > > [...]
> > > 
> > > Please be very clear about exactly what security properties are
> > > achieved
> > > by
> > > using encrypted-keys.
> > 
> > I've left out all of this in the updated documentation, as any such
> > information should probably be in Documentation/security/keys/trusted-
> > encrypted.rst in the first place.
> 
> Where is this document going to be found / when will it be written?
> It seems really odd to be requesting a do code review when the
> specifications aren't available and/or haven't been written yet.  I
> prefer to review the *design* first, as opposed to trying to both
> review the code and try to guess at the design and review my guess of
> the design at the same time....

Does v3's commit message https://patchwork.kernel.org/patch/10173189/ serve
as a good enough design document?

Cheers,
Andre'

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
