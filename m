From: aaptel@suse.com (=?utf-8?Q?Aur=C3=A9lien?= Aptel)
Date: Thu, 16 Aug 2018 19:23:23 +0200
Subject: Should we split the network filesystem setup into two phases?
In-Reply-To: <CAH2r5muKOWBe9zMM8duNJ3rp1bzQh-mUj5zYoARO5pmc4de_+A@mail.gmail.com>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<17763.1534350685@warthog.procyon.org.uk>
	<87pnyiew8x.fsf@xmission.com>
	<CAH2r5muKOWBe9zMM8duNJ3rp1bzQh-mUj5zYoARO5pmc4de_+A@mail.gmail.com>
Message-ID: <87tvnuz0ms.fsf@suse.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Steve French <smfrench@gmail.com> writes:
> In cifs we attempt to match new mounts to existing tree connections
> (instances of connections to a \\server\share) from other mount(s)
> based first on whether security settings match (e.g. are both
> Kerberos) and then on whether encryption is on/off and whether this is
> a snapshot mount (smb3 previous versions feature).  If neither is
> mounted with a snaphsot and the encryption settings match then
> we will use the same tree id to talk with the server as the other
> mounts use.  Interesting idea to allow mount to force a new
> tree id.

We actually already have this mount option in cifs.ko, it's "nosharesock".

> What was the NFS mount option you were talking about?
> Looking at the nfs man page the only one that looked similar
> was "nosharecache"

Cheers,
-- 
Aur?lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstra?e 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
