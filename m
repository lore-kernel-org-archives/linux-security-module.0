Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683945;
	b=SeAdvMxZsUHgyeGW69bhd0JSOk47m7w/8zesQZUKD1taeFt9A749NC6A1t+KKUP7QseY
	 uyKYsr6YArmyRlxoCCA7bafKrZ2wZFgpo166Roa4b51hQS9GkWCbQsM5b1R6fPyZAr6cH
	 FEjZzJonO51YqxtoGuSasUC47cA7NQ5hhiX7B7y7tjR2hLTrhqMzgEtGuebAxHbtD1yRR
	 XUWQmJ2bhRPXtXIIRSCvup9jSusxHXT9Qf2PXYSsQr9izSZzng+bFpZ2YddEi3LA+1kKa
	 FkGsOxYfoQ3fcYXH6G3Lso5SXOUPAlv83s3rU7pkaXb4FeLj5aHK9dce2wSSoW+ABBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683945;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=e5FM9vVnkaYr5oiSZF4qGOvuP/i123ZW74JzPvuX6pg=;
	b=klSnt5/4bCucfrqxssMYsig50aJrmmqE5VmAOChXwHq3Rc2w0YP+/TiBzZd0yT+Dp1HV
	 BVz5RdVpPUVzwTz2iMf7awM5cMZRhJYAGacLDRr2XPsEdw9NMIAZJAetET/iz0DdxN7cm
	 TvzHBv0jkIiVu4Ur4cjfYJtVkQK/uR+cqSuRRvkR0NVGUQsv7de0lO41/l5r1fDFR1AUZ
	 bOlitl6ot+yS9j3VqnjAKf+zy+ozbeaGu0sNn+8Ewy47WW+zwzNQEZn8pLnjVJA4HFSPk
	 xMUE39qu0D5rloa64ooaEnIRAUOCN+PpZQUeVAIS/M+omdsUViC9f9hmV9TDm1OfUTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2Aj1MXJl;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aKDUHDex;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2Aj1MXJl;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aKDUHDex;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75616606A31E;
	Thu, 26 Nov 2026 09:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75616606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2Aj1MXJl;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aKDUHDex;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2Aj1MXJl;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=aKDUHDex
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A246D21D8F;
	Thu, 26 Nov 2026 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795683936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5FM9vVnkaYr5oiSZF4qGOvuP/i123ZW74JzPvuX6pg=;
	b=2Aj1MXJlIYpqdmjnsQ0sPyQux4kSV5g4Dsvpn6MzW7FExaq2EkvverSLjQXcNc+6bKKtoy
	XxcllSyZ+V7edM65UBTv09Yhg3V1KYx1lxcmjqqR+CDO5ZEFQHWH+N1a/+UGiHumsuLmTt
	ctIrIlDk/wLwqOwjhdBQgfX+DCCOWFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795683936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5FM9vVnkaYr5oiSZF4qGOvuP/i123ZW74JzPvuX6pg=;
	b=aKDUHDexsKNu7mk1FQDN4+wzC9n5YJr8g3hfI3/jNWMmzqqRUZXH69IyO/q+qyDg6RgAIb
	u9PtFijfU1TL7JCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2Aj1MXJl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aKDUHDex
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795683936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5FM9vVnkaYr5oiSZF4qGOvuP/i123ZW74JzPvuX6pg=;
	b=2Aj1MXJlIYpqdmjnsQ0sPyQux4kSV5g4Dsvpn6MzW7FExaq2EkvverSLjQXcNc+6bKKtoy
	XxcllSyZ+V7edM65UBTv09Yhg3V1KYx1lxcmjqqR+CDO5ZEFQHWH+N1a/+UGiHumsuLmTt
	ctIrIlDk/wLwqOwjhdBQgfX+DCCOWFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795683936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5FM9vVnkaYr5oiSZF4qGOvuP/i123ZW74JzPvuX6pg=;
	b=aKDUHDexsKNu7mk1FQDN4+wzC9n5YJr8g3hfI3/jNWMmzqqRUZXH69IyO/q+qyDg6RgAIb
	u9PtFijfU1TL7JCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73C03134C3;
	Thu, 26 Nov 2026 09:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /qoxFGD2B2ufTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Nov 2026 09:05:36 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id F321627D9A; Thu, 26 Nov 2026 10:05:35 +0100 (CET)
Date: Thu, 26 Nov 2026 10:05:35 +0100
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
Subject: Re: [PATCH slab/for-next v2 04/14] fs/buffer: specify
 SLAB_MAY_ACCOUNT for buffer_head cache
Message-ID: <gmnosp2u47xewnszzrx4asmldxsyjtejyrbrng2ckrcfedymeu@evhwupv3iwhf>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
 <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-4-7c680f02a734@kernel.org>
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
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-4-7c680f02a734@kernel.org>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,google.com,cmpxchg.org,linux.dev,gentwo.org,suse.de,kvack.org,vger.kernel.org,meta.com,infradead.org,gmail.com,zeniv.linux.org.uk,suse.cz,davemloft.net,linutronix.de,arm.com,linux.ibm.com,ellerman.id.au,8bytes.org,schaufler-ca.com,paul-moore.com,namei.org,hallyn.com,nod.at,cambridgegreys.com,sipsolutions.net];
	R_RATELIMIT(0.00)[to_ip_from(RLpgg91yox7uqmadgh65wjkwtw)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_GT_50(0.00)[51];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: A246D21D8F

On Wed 25-11-26 21:37:05, Harry Yoo (Meta) wrote:
> Buffer heads are allocated with __GFP_ACCOUNT to charge them to the
> memcg of the folio they are attached to. Specify SLAB_MAY_ACCOUNT when
> the object may be charged to a memcg. __GFP_ACCOUNT without
> SLAB_MAY_ACCOUNT will not be allowed.
> 
> Path: ext4_getblk() -> folio_alloc_buffers(GFP_NOFS | __GFP_ACCOUNT)
>   -> alloc_buffer_head() -> kmem_cache_zalloc(bh_cachep)
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Looks good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index f951559e7d32..4c24f4546106 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3006,7 +3006,7 @@ void __init buffer_init(void)
>  	int ret;
>  
>  	bh_cachep = KMEM_CACHE(buffer_head,
> -				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC);
> +				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MAY_ACCOUNT);
>  	/*
>  	 * Limit the bh occupancy to 10% of ZONE_NORMAL
>  	 */
> 
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
