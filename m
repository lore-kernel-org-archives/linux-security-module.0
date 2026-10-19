Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422177;
	b=1+Shs18EelD72UqjFIu/uN4fHuYuR/pUsCYXDWTtoZlbA2xC8+fXN/l5CNdmNMez1Y1x
	 IuCUZ3nz9fSCOwV1ddzNyAD95gD6ycWgasXsA+Zu6+T7taUHvqEwsBDHVIOwpJvjw82NY
	 UgcYWlOuC1UbOSW8bNdJRk74HR2U42hrSSBKuZdI47anf5gIURIjlCcWA9Cu+QMAFtHbR
	 eSKsjWmMehyycl2pyvbW3Yirc08UnpW/G+31LT/UYoHpfFAsxr8LAoTE6PwYa+txYzSx4
	 SjikjLMeqqpxDKqO3dDrRWmuBNlM0vEDxti8WamKbv/EakHlQ8igpTW3MaAnKVLM0nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422177;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Organization:From:In-Reply-To:
	 References:To:Cc:Subject:MIME-Version:Date:Message-ID:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:Content-ID:
	 Content-Transfer-Encoding;
	bh=0aR/twqgPDPoIHrAvxSaoPjwMC1Tu93FeecENyLSVH8=;
	b=NuWqg5pLrZIz+PGkKAd8Z4PTAsgjWfWhO4Jk64Vn/hQ/QcHaLoCarBDM9VPtNFzPUr5w
	 5iK3SjYidrBDRg/8jlMKl4YCEl+9xtvhylYu3HDrHaMHjBnSzVncaryf23MHtHiZ2F21X
	 1zHWxoR0IINhEg0J76RPf4tV6vQSTodeGIiS6W/ojRiG+hTkc/scV53JwTitS2isErSWj
	 HyNRQstjIa0W3ompFbYzQZlpOGj4EdkNVEX+zdEMGYuS/NHlKGyHhdLK4xO2Mf7KUdDGx
	 D9QgHe0tXEbFqQk9fTXeryJ+lzB+w1rZilfleCpx0SnEKlp80d0zxqM7rVwnqp0A7YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anVm7Xoz;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26A607BF36
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF26A607BF36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=anVm7Xoz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792422175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aR/twqgPDPoIHrAvxSaoPjwMC1Tu93FeecENyLSVH8=;
	b=anVm7Xoz8I6OKKVZLonabuMRd7BEqpnofC7r/f4Sst7Oc9z18fdBdo/+Jdf04OIGOWM8lt
	76CFVvUWW2NYfyKRuNtplP4KwOrBKqORbd70v28xhFdL8AhgxlXBqJAnX97QjMMnVRTsm2
	vAx+zLneJ6jmdylm3ToWcy4o8drFQ5A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-zTfVQHItOKawKXPO1Yy_uA-1; Mon,
 19 Oct 2026 15:02:54 +0000
X-MC-Unique: zTfVQHItOKawKXPO1Yy_uA-1
X-Mimecast-MFC-AGG-ID: zTfVQHItOKawKXPO1Yy_uA_1792422172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41CE01954AD3;
	Mon, 19 Oct 2026 15:02:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.11])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 653A030001A2;
	Mon, 19 Oct 2026 15:02:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20261016215326.4110064-6-jarkko@kernel.org>
References: <20261016215326.4110064-6-jarkko@kernel.org> <20261016215326.4110064-1-jarkko@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    linux-kernel@vger.kernel.org (open list),
    linux-security-module@vger.kernel.org (open
                         list:SECURITY SUBSYSTEM)
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct keyring_index
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 16:02:48 +0100
Message-ID: <2608630.1792422168@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 9WGYAfEPXumM1Ihv31BqExorx1rWP0I7P2Lv_u_tSww_1792422172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2608629.1792422168.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Maintain two linked lists in the index:
>=20
> - all: enumerate committed links without retrying hash table walks when
>   the table resizes.
> - keyrings: visit nested keyrings during recursive search without scannin=
g
>   links to other key types.

Do you actually need two lists?  Can you just "sort" the list to put all th=
e
keyrings first?

> +=09=09=09struct keyring_index __rcu *links;

Does that actually need an __rcu mark?  Is it going to get replaced once
allocated?

> +struct keyring_link;
> +

Somewhere near the top of internal.h, please, not sandwiched in the middle =
of
some func declarations.

> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -14,12 +14,12 @@
>  #include <linux/err.h>
>  #include <linux/user_namespace.h>
>  #include <linux/nsproxy.h>
> +#include <keys/keyring-type.h>
> +#include <keys/user-type.h>

Why #include user-type.h here?

> +struct keyring_index {
> +=09struct rhashtable=09ht;
> +=09struct list_head=09all;
> +=09struct list_head=09keyrings;
> +=09unsigned long=09=09nr;=09=09/* Number of committed links */

Given key->serial is 1-INT_MAX, nr probably doesn't need to be unsigned lon=
g -
otoh, it's not likely to leave a hole, I guess.

> +struct keyring_link {

I wonder if keyring_entry would be a better name, but the docs do mention
making and removing links.

> +=09unsigned long=09=09hash;
> ...
> +=09struct rcu_head=09=09rcu;

Can they be in a union?  And I would put rcu first as I think there are (or
maybe used to be) some things that required it to be first.

> +=09struct list_head=09keyrings_link;=09/* in keyring_index::keyrings */

This may be unnecessary if you can put keyrings at the front of the list.

> +=09struct keyring_link=09*replaces;=09/* Link this one replaces, or NULL=
 */

Please don't put this in keyring_link.  It's only needed by __key_link() an=
d
friends and could be passed around in a context struct as the edit script i=
s
done now:

=09struct keyring_link_context {
=09=09struct keyring_link *spare;=09/* Spare link block */
=09=09struct keyring_link *replace;=09/* Link being replaced */
=09};

then:

=09 int __key_link_begin(struct key *keyring,
=09=09=09     const struct keyring_index_key *index_key,
=09-=09=09     struct assoc_array_edit **_edit)
=09+=09=09     struct keyring_link_context **_edit)

> +/*
> + * Remove every link from a keyring.  The caller holds keyring->sem
> + * write-locked.  A concurrent RCU reader can see some of the links gone=
 and
> + * others not yet.
> + */
> +static void keyring_remove_all_links(struct key *keyring)
> +{
> +=09struct keyring_index *links =3D keyring_index_locked(keyring);
> +=09struct keyring_link *link, *tmp;
> +
> +=09if (!links)
> +=09=09return;
> +=09list_for_each_entry_safe(link, tmp, &links->all, all_link)
> +=09=09keyring_remove_link(links, link);
>  }
> ...
>  int keyring_clear(struct key *keyring)
>  {
> ...
> +=09keyring_remove_all_links(keyring);

This can be made atomic by replacing the key->links pointer value with NULL
(since key->links is marked __rcu), then destroying the content afterwards.

David

