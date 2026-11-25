Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642770;
	b=PRFNSbMHBojbE35sjhn5TRrI0UUc/VGkNnx9SpOOkVflFxJrPGBArCHkR5bg1lMV9/GK
	 oW5GPonQRYWJXS+uvgEexDKGfg+F6v8hl9YQaUkoo6s5WLC4xNSdzsPID94KeB+HQMEkw
	 Qu4NXcoToK7IZPHYiTGUda3INiRBKelXR8A+MmjGMivFGLClKdIUf7AXp0QOH2mn5uoDd
	 zhqFRfReuxLDNITwwu8uY7+RkiyhQrYLQj+BOqTDA/sb6w1yX+lOoViEJWDpoE1E0LmYU
	 jPz0NVMl7jrviktOigbv+eXlbjVOl0lCxJsoWWEpWyR3vkyg4YOj0fKhssnMXw6r8WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642770;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=uchKMQEbun1KGuNSoqThhgELpVgiokvVWjr9mK1k/A4=;
	b=IXCQbRAEYnUjs0asrdJjcgga38CR81EWAursB4jY4Xsr7NYwPQb7W2OdKtBVjLOdgp7M
	 qUQyXPrT/Sgnr/UyrdGFMtecIXFpB1ctUNU9DrMJusQ1dd3Jo5YtY3VUcVAbyPVtnM2zQ
	 pWSWzOyIDG4e/SvGIUYOLoycLPA53cdOeJBvl+JtrQC/oCLNjVlBgzW+7IZLsN7nHqueE
	 4/wmwsBEtJRqFuY60l6WkWA0A99DM4C+49Zgo+hxeiM1Mx48izVD0AY7tQL1rkQ/xN5xS
	 BUCrD38u3vV4aZhBCH1L+Sdo09uQ8LpTJGwJzoRQg4l2f/X8IJuNP/JH0ODtlRrtlqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnxwhmZD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D4606A323;
	Wed, 25 Nov 2026 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnxwhmZD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC941F000EB;
	Wed, 25 Nov 2026 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642769;
	bh=uchKMQEbun1KGuNSoqThhgELpVgiokvVWjr9mK1k/A4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cnxwhmZDXM+Gsf0EhyO5VD88+p/C9GrSlfOXwoM8uURHlT5OqfIyp2Rk5t4izPM3P
	 UUx1iGYMBxTWs0cL3dCa2FA04NGRrpI4ftwFOBvtbII2klixx84KhPEvfJOjk+TwJo
	 DFc6Qi1OlbLb6T2cbEG1CRPNtaCZk/R58jMv+IibTCsr8BptHZoUgMiJ2jnJbsExBK
	 Q+MoCouRcesMmoAwbmZrOxAbLuJxUupraT9lUd2s7+j6/4EPjYtXHaUu0/aXvLlyvR
	 SEBhBNJRRsmdB4Q6buLNKRmyi35fpFhzWJhgqoKVgCyvDfHsSFNTIFHNt4CE5+GaCp
	 TsEGvbU9H6XSA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:11 +0000
Subject: [PATCH slab/for-next v2 10/14] fanotify: specify SLAB_MAY_ACCOUNT
 for event caches
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-10-7c680f02a734@kernel.org>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 "Harry Yoo (Meta)" <harry@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Eric Dumazet <edumazet@kernel.org>
X-Mailer: b4 0.16.0

fanotify events are allocated with GFP_KERNEL_ACCOUNT and charged to
the memcg of the listener. Specify SLAB_MAY_ACCOUNT when the object
may be charged to a memcg. __GFP_ACCOUNT without SLAB_MAY_ACCOUNT
will not be allowed.

Path: fsnotify() -> fanotify_handle_event()
  -> fanotify_alloc_event(GFP_KERNEL_ACCOUNT)
  -> kmem_cache_alloc(fanotify_{fid,path,perm,mnt}_event_cachep)

Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 63c9759fc3b0..3575c681abc1 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -2184,14 +2184,16 @@ static int __init fanotify_user_setup(void)
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
 	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
-					       SLAB_PANIC);
+					       SLAB_PANIC|SLAB_MAY_ACCOUNT);
 	fanotify_path_event_cachep = KMEM_CACHE(fanotify_path_event,
-						SLAB_PANIC);
+						SLAB_PANIC|SLAB_MAY_ACCOUNT);
 	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
 		fanotify_perm_event_cachep =
-			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
+			KMEM_CACHE(fanotify_perm_event,
+				   SLAB_PANIC|SLAB_MAY_ACCOUNT);
 	}
-	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event, SLAB_PANIC);
+	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event,
+					       SLAB_PANIC|SLAB_MAY_ACCOUNT);
 
 	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
 	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =

-- 
2.54.0

