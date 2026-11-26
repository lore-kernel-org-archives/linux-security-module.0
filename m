Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703020;
	b=b9iAA7HKUGof7rkBR+1wjrTiAL5Dyf7nA14fql+m0WGfWZJJk+KEyKJnaFcQQmTU2XvX
	 VNqowhsjyGPfwuhc7zwxj+GrcfsLqUCura637aVfm3xBpfdbS8yjBgytEU966xmZjbHFk
	 GETQ/eDMBtIQcuQ6jnzYcnP1OiJBd6q7aW0+UCU7UyD/ZmyPK7zNg4RQkjrGVvDcBe7ZY
	 GrRm7BF00bswSaHRklOJJnwdZcXAXWJQilB5D6LCfle6dVbNFdFtU1uQHTqBfVd/OjKFh
	 hP/UJ54VY8/COEzgpMEEHpFpOH1XuqdsPDX3ynUMViclcFbK79rHZXTFrYrYJc+c9HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TM3nSQU4U49T6GuNdT3oigc7kZQ4pNCPYHhbPmQrcTg=;
	b=DvyUu9OvwW4+KqMUCQPvIf5+quKQ/cSpVEsuPyefEp92mGudhRF/6xpl0WQfBJ+0X0bW
	 NWvnSOlpPAd23F2X6O4SHhjUXFcQvZi0XuiJvX5pYocVitRI8GEebN11C08kffnAfEHdh
	 P1LExnHKcr6tLjQOH5YuYx/XbZS2LJPOBYtx4W+qfphutBH+3w/2a/6bMEycrLgoX5o4e
	 kn0lqZbpWE8DYtFIIAOo8I/iUfsf2HlF+QqDlReMUUXNUz0AMsUh2WbXPhtPXXmdtHsID
	 luumCDcETE5IK8e6QET+lg++BFKGOKURh2ZvXFprgTbjCqtmEhnqoc+JIfAVelrF5QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLtgzE2m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D412606A31C;
	Thu, 26 Nov 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLtgzE2m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2CE1F000C6;
	Thu, 26 Nov 2026 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703019;
	bh=TM3nSQU4U49T6GuNdT3oigc7kZQ4pNCPYHhbPmQrcTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cLtgzE2m1YoJXGpueRMJ0WG9tvSKfNQlB02h6sqo7+CT8SIX7diyIjeNQZEBq+Rmt
	 c3wVUQBaScWcqNmdizx9oeZqhcQnvwkubrAnPGao9ZHg/pRNuxscJLtGFEwWhyKHZe
	 nD/eW4RvR6/G4RIOLr/J3D0i1W1bfaIVV4gV6Xo1o3NxvrDYmUXGUKIoxb5lrWYo0q
	 Xm3lS0pcjZzeAgfeDD994mnwvbbJ6Bb4w8QRSJ88kkDhfkdRtNyJf6tq4OTMhrIQma
	 cQteoWOcf297BZrDLqN31mAQGOYddmIaQKOZUGDlnYAJ1X9HJwRkWGecY/FtSID7JT
	 LyLKLX3iIqGPg==
Date: Thu, 26 Nov 2026 14:23:37 +0000
From: Harry Yoo <harry@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, "Liam R. Howlett" <liam@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Amir Goldstein <amir73il@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH slab/for-next v2 04/14] fs/buffer: specify
 SLAB_MAY_ACCOUNT for buffer_head cache
Message-ID: <awhA1sW94lviTsgT@thinkstation>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
 <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-4-7c680f02a734@kernel.org>
 <gmnosp2u47xewnszzrx4asmldxsyjtejyrbrng2ckrcfedymeu@evhwupv3iwhf>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gmnosp2u47xewnszzrx4asmldxsyjtejyrbrng2ckrcfedymeu@evhwupv3iwhf>

On Thu, Nov 26, 2026 at 10:05:35AM +0100, Jan Kara wrote:
> On Wed 25-11-26 21:37:05, Harry Yoo (Meta) wrote:
> > Buffer heads are allocated with __GFP_ACCOUNT to charge them to the
> > memcg of the folio they are attached to. Specify SLAB_MAY_ACCOUNT when
> > the object may be charged to a memcg. __GFP_ACCOUNT without
> > SLAB_MAY_ACCOUNT will not be allowed.
> > 
> > Path: ext4_getblk() -> folio_alloc_buffers(GFP_NOFS | __GFP_ACCOUNT)
> >   -> alloc_buffer_head() -> kmem_cache_zalloc(bh_cachep)
> > 
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> 
> Looks good. Feel free to add:

Thank you for reviewing them, Jan!

> Acked-by: Jan Kara <jack@suse.cz>

-- 
Cheers,
Harry / Hyeonggon
