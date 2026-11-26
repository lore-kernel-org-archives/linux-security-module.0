Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684005;
	b=k7iKrtb7quyCotECu37SGzxDdaBYmmbJaYc4n/ccsVKaiy5HKoks73sP++zTpsFdjVV7
	 NJ0jBx7pvUatzS40TyHnbGq4buf559c9+gVr5LZ5CzRplSr5HqGj/kswYcfXKaIou2LUR
	 sqn7GKvOxgsj9GHq7rOLl9+ovKiyF97Duqf8Jfs1mVuN69v4fsNgksWOP0PYhPieEy0tA
	 qi9GUC0F1I3/oaxJ1OAjQHr6F1wsnS85AKExLhcd4ImD+GQdAiYG2KF4DhUTcxIGJACnx
	 Rs166jeyzs4b9QiMykaOoZxD/Cyr1O3ohX/78ljmXdcJBsAhaIitz6ZeKH3a/fVP7Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684005;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=39yPdNuJb0udHLAJFrorC5cCcHhnCJIncBEZ1J342vU=;
	b=F5HnWLxX1Nlprmzc6XD3jiJpL+eKC2sO67MEkB66DIEweLGC/A8raw5L451sOPgcX5UJ
	 UZfbPaJjGntHotmVH0Id79U88KNEOH5Cd/Sr/+0pj39DiJNB68kzKbnTj7Sd3mZPKV2CG
	 WpzC7nAnY3cPR5MIa/gUTU9I2NOg8xojr95UP0g7JhwKA9jKvcJo/gVqwZ39RXbDK5XYw
	 hhfb+7SH63OoAxT/3DPRAUPc1cCI9utgqtE1jQ14C//dkvsNyEtXkEsge55QbMnLpy9cS
	 EV3KVfV8wZke6K7HmJWg+MxEHMNUa6GkHCJKoXidBerI7ZIC6UgfNYY2Os5rHy+vL6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FrHK60xi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9SPaV1VN;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FrHK60xi;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9SPaV1VN;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A72606A31E;
	Thu, 26 Nov 2026 09:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A72606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FrHK60xi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9SPaV1VN;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FrHK60xi;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9SPaV1VN
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E71922688;
	Thu, 26 Nov 2026 09:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795684003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39yPdNuJb0udHLAJFrorC5cCcHhnCJIncBEZ1J342vU=;
	b=FrHK60xiPLeKlT1sSH5Q20B2+d/AbScE9RcAHGXZhrD/3jTYyClPEpX92WSF1W0zEnuV7i
	JW1gzl5z4Tq3LoafQjvoXXo5LfTiVX5bpn3tC2r77oUsrGutCcvbQhOQTXLAOYiGrUDiKq
	aM3Dq+nCb8seaEN7ZI5shQrPOsllFZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795684003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39yPdNuJb0udHLAJFrorC5cCcHhnCJIncBEZ1J342vU=;
	b=9SPaV1VNP8RzeVfIHQf1g3LXlIJAsbPen6y8ZFMgxQS707IWLOlJe4SyZ2PL7gEkznrvW+
	p294Re6jlcOzVBCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795684003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39yPdNuJb0udHLAJFrorC5cCcHhnCJIncBEZ1J342vU=;
	b=FrHK60xiPLeKlT1sSH5Q20B2+d/AbScE9RcAHGXZhrD/3jTYyClPEpX92WSF1W0zEnuV7i
	JW1gzl5z4Tq3LoafQjvoXXo5LfTiVX5bpn3tC2r77oUsrGutCcvbQhOQTXLAOYiGrUDiKq
	aM3Dq+nCb8seaEN7ZI5shQrPOsllFZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795684003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39yPdNuJb0udHLAJFrorC5cCcHhnCJIncBEZ1J342vU=;
	b=9SPaV1VNP8RzeVfIHQf1g3LXlIJAsbPen6y8ZFMgxQS707IWLOlJe4SyZ2PL7gEkznrvW+
	p294Re6jlcOzVBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6906134C3;
	Thu, 26 Nov 2026 09:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hMxfJKL2B2ubTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Nov 2026 09:06:42 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 5978B27D9C; Thu, 26 Nov 2026 10:06:42 +0100 (CET)
Date: Thu, 26 Nov 2026 10:06:42 +0100
From: Jan Kara <jack@suse.cz>
To: "Harry Yoo (Meta)" <harry@kernel.org>
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
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
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
Subject: Re: [PATCH slab/for-next v2 10/14] fanotify: specify
 SLAB_MAY_ACCOUNT for event caches
Message-ID: <5ubs2kqiytosrur35di2zlg26c7tfjjadjvqrp447utjxaozbl@vrjndb7avfa4>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
 <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-10-7c680f02a734@kernel.org>
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
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-10-7c680f02a734@kernel.org>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,google.com,cmpxchg.org,linux.dev,gentwo.org,suse.de,kvack.org,vger.kernel.org,meta.com,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,davemloft.net,linutronix.de,arm.com,linux.ibm.com,ellerman.id.au,8bytes.org,schaufler-ca.com,paul-moore.com,namei.org,hallyn.com,nod.at,cambridgegreys.com,sipsolutions.net];
	R_RATELIMIT(0.00)[to_ip_from(RLj6phwcdhphrxdye3znxh4wb5)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 25-11-26 21:37:11, Harry Yoo (Meta) wrote:
> fanotify events are allocated with GFP_KERNEL_ACCOUNT and charged to
> the memcg of the listener. Specify SLAB_MAY_ACCOUNT when the object
> may be charged to a memcg. __GFP_ACCOUNT without SLAB_MAY_ACCOUNT
> will not be allowed.
> 
> Path: fsnotify() -> fanotify_handle_event()
>   -> fanotify_alloc_event(GFP_KERNEL_ACCOUNT)
>   -> kmem_cache_alloc(fanotify_{fid,path,perm,mnt}_event_cachep)
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Looks good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 63c9759fc3b0..3575c681abc1 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -2184,14 +2184,16 @@ static int __init fanotify_user_setup(void)
>  	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
>  					 SLAB_PANIC|SLAB_ACCOUNT);
>  	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
> -					       SLAB_PANIC);
> +					       SLAB_PANIC|SLAB_MAY_ACCOUNT);
>  	fanotify_path_event_cachep = KMEM_CACHE(fanotify_path_event,
> -						SLAB_PANIC);
> +						SLAB_PANIC|SLAB_MAY_ACCOUNT);
>  	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
>  		fanotify_perm_event_cachep =
> -			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
> +			KMEM_CACHE(fanotify_perm_event,
> +				   SLAB_PANIC|SLAB_MAY_ACCOUNT);
>  	}
> -	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event, SLAB_PANIC);
> +	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event,
> +					       SLAB_PANIC|SLAB_MAY_ACCOUNT);
>  
>  	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
>  	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =
> 
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
