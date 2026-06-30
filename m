Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFC3C8724
	for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838040; cv=none; b=oioKdKRPGE34UjS/4AVC9MM35sQrgCyVZrXWXBKqpE+wHUpqUFltV19jKz8PQQCMu2VysA8IZFB+KyW6SGzOu5QhhVQMq0L92pBKUSRZDWKqq6TGGF7/esoGB4ABKXcMcLH5g53a8qhKKWrUaP/BzXW1PkGoDUjZ2Ypv8WSS+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838040; c=relaxed/simple;
	bh=wm5DHdFF8D7xpEBn6Vx5ECjIg9+tFlUcBj+FPeN9rzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ/PsvjAAAofLPluUX+N6tuR6YHGojIGeSzKNEVBOd+0GJsDYhFJy38MJ8RKU9FeW3n1jsAKZdnxyVyXkgoxRZP1d7NzXTq7V1KLENG/dn8ys3q3Tw7sH1i1jRJRVltgzX9jaU6eqzZ3SC/FeDunBrfXcgWYUOsFMsxqvvyH0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=i5UgRVZA; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i5UgRVZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782838037; bh=w+DSqPqb/ApyykNy+dGJ0PSYL1qJiLq86yl+oH/5ZaI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=i5UgRVZAN7Qd31WgDmadnOIVhjXl49bxfxLEw3buG3n3+TctObzngXDwoY4v5Yy9Sibx4L/APIbK+GX22LIMlwE7cIMevHrqtEQUKHWJfnxHwj3xLGSB3N7LyAGfCo1TG+PLblAUmqmPd//BX0Pm/XvKIPMDSsQegI6/Uo50l7qW4va/vHS6xQ7PYQI8WvMln16eK0wnbdoHWCpgGpFFNpb+9s4jwl1wt9TcUqTmHPUhl4YBS60X74hXrZB5wYEdeR006PX6Q5D9CZxBiU8DV1iWfXRQxuoYplGLLVHukD89wztZCTRn1idl7D6QYzaYVBWkS3yZDdlnoIh4pM9jdw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782838037; bh=QOqjpqQ2iMBUqrngel7+oFVerrt3f2i+qr+5utQ5FiO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=XYbNZJR7OuuVyXSJiLecwkZ4hrNsrfqJbRAuB9OS1AfHnoDtk8eRlTVVpMQR+QjPiswM5aS5TrBaFAx/Q3bqE5ERzMboQjV4IiyPVZ3Bl3vK0c/brlMnlNAeLZd9NWtrxNMU6L1z1Uv8CQXQTvFnFuUdTE1hX08lP/199ZuVcd9J9hCnQHSlc2XmCCpdAr92W1OF32KaOoSfMYcfFszd3UQ1GyG5Bd+JWX2YW9UgxdYymxwBEILNloDzl5XbEFb2RWPZPkYvfuU1OZJgeslNYbsWzr7S/BlOFwCP5G3lJwc4PKwjlA9Bad3BsSqyLDhlUKl3sQ5HJ5lmrsIe28UUhA==
X-YMail-OSG: kYOU1U0VM1l0PoIFXNmWEskfLLBzdrB.0sS5aUemQgwXfYfGQtVOXsLVw0xe8Yz
 DURo9KNrBDo1UqIFkcI21mSbocuAv3AmHbyHfq5BFT0V5GlM2MGk.UQT0WuKPH8gwqyQEt9jlLrr
 UEpfjJ4d2rYPP4SudKcl2OijSay6f0EgtyCg.74khC72obh53uCc5FVcONNtgHFQ9QdFEtWobKOO
 lltilzLbybOWkad0275ylqwDAldyls_7OZPMxT.ju4uCi5WTNcLZdwlzfYPwpYA.D__h.eqGiAXk
 TQpy4GWd8dXRxV41Dyxk2zkP_lEz0PjNy32ROn1IyZGzz4HBrLlQihPvmkWhfc_yHX2dZ9Fb5tos
 7t1V1vOUIKeW17Uiw.6cxJ2Byoip10tEr3ns1CJNDIzNg2Vz3xvDCw_RzoO9wNK4QbJSWHjV8dao
 5neYQsCB.eoYrwVKKH1FRsA0buardfOf125K.maWi83NtqhtIrrTvBPI4qinchAXlWw9_rxZ9ldF
 ZmEcVpmI.a5pgRsqK5SMG4PFhsK90qPiSEB.y8AVBc_iRAcc1p9Ti5L9lF5Dr1eG5KdjNIJ3VqnF
 cMahnHd_cw5wiDWvUYlLO528hsyhvMlOR4atzagX7nFQhhKJYZ2QAjdVl_8Z2.ns0oEZVMEs8Wo0
 _KRCfbOYLggqra4BHe4rGk90hsdGQnlgk9_8zZTg8M96iwSRkaoDHvfbmYhegBY6tTY8ZanD9FZj
 huxXsCnHMKBEJ0epPpIM80UDN3iDRuqxNE8EEI5Z2T_g4oGmcDsNMm9ImUt5m61COxTgXjy5boNl
 5SHPUK2bUpz6UVfa.W89tb1fgXYia6BX8Z3ygXBrShHaH3Bl0FWAntURYsb4dYao__abOCcQHf06
 XVMbVKPKYNK_lhjde3ZRwK2Gqg2FZK_Pct5_XTjMpOR4tkjRh8tEBCb68wGkvkhphAxQxqatoNIK
 TYx1U13oXoxe2dum.Sml_kMfHiJBAxEjfO.OoK4dSjVgdpPQRdnz2Z2kJx.yRtNJ87tRZWFtWitH
 nng540l47N0zOsiAClX62zLMuMfrauR_StTobF.5jYgW2t1BX8Jg4SB49cMsReDTDYNeCR79KxRB
 nuYACyLshjOIXeengfHH_crVmOtPcY7c4P0PUQi41sYDL2qe48kKDPcD5yQHc64UzKLoYmYM9aT7
 lYVxTWgJnBMOR8hCKYmGjTfrNHxrJjFYkEFy9Tf09ui3mXXaGJoB9TiNOopovgmLFqQKfGq.SfPB
 F4yR3ia2zuUiNiwJI.L5g089GRrdv_Qhi9sInRy5Tjv6EgNNa3epAVKzgquLukUM.WKo7j.36meC
 X09Ht30rIyi3pVYDDkxNga9vqhMoDd1m8uBgn2oej4Dl_ENpN00vkyFTG9ITmduUWmNtZVSq4ipy
 CgSZ9NYfBFpchNjPXMkNafYZnaRrcV4zSGlqg35JwkmR6uISM9dtrH2wxp50QwxRk6VO9XXzPeMP
 yOg7zUhIXNfNt1u.dn9Z.9RgIu4klSvQM5pa8B9pveiyGWx52CyO3xTpwtnc8eq1wQagEzOTghBh
 ZROqPiuoyFzc.q68GRtWft7d6_TIcmq7UV_oggOvvf9drOT_1ZTdCh9TAMX_.b_9Q018vdu_P45B
 iaKUJb96aa31J_CiMhAJk2q3ZdyEaROuwjX1tMe1XKB7W9d0s7G80VCZ2pmnt65qqgCIXBTzEM1P
 WxnNnq5pnu_O4OSvps1oIvTqZVO.D4u8Kp7G4HqjuZRX7mcbpqNvD7u6ffzGRS6TV.HX5u.lPPuU
 AKGmXNvI2wNCwAnBlykmnPmwEG0Hd5c3T8o6G2uxntmGMz9rzZSW9adIYTsq8CYiIHCzuM9OAqiV
 LHBma9.lnrRp_G8SUz4VDiZh4J6taP.o73xbuDe9S68TCinVs7izhPTb71IUbFl.Xp_lhpvQjcJV
 jUcT1KBjALqYj7iu2ol0GMKlmsNbORm.F7bqVvSk6BPhfB9_gF0A5eZg4DzoNtI3APAIDoNIYxsH
 FcfsWDum3t6lDVmrchuju_fBQTd18.M.9uW1yq1rYzw3erS1ddfhUTXQ1ZtL8MjLbgwnYfUCUyYK
 JlpQo5vJ31kTEl2DW3wp25qm3fA3L0i5XYHkC_h4IWfOl1uY4XW0.05d769ZPO0HS4io9u0zMKMt
 f9fZL3Z27wepbHng.2z496NMaO96ejop3kIIdtFvQMTQWKWPazRZassbz7SxvEBwQPjTIEDysOYM
 yEpjyh01UacOEQRkjmY01w_weFqIL2BFFXoiE2L5YFsf1yzRYHVwtTKEHFcI1k49Ej4Qy.TA0fd9
 Xddod5Rbb8OTMpU0MfH.1RA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 647a1600-dfb3-4636-ab1c-a14f24ddc600
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Jun 2026 16:47:17 +0000
Received: by hermes--production-gq1-6dc558886b-fwhhm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e7fa2098ce22e9ccb82af723c7f96a9;
          Tue, 30 Jun 2026 16:26:38 +0000 (UTC)
Message-ID: <a58c016e-8d38-48c0-928b-aa622aa17e2b@schaufler-ca.com>
Date: Tue, 30 Jun 2026 09:26:36 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: cleanup repeated lsm_blob_size_update() calls in
 lsm_prepare()
To: Matt Bobrowski <mattbobrowski@google.com>,
 linux-security-module@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260629210150.832576-1-mattbobrowski@google.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260629210150.832576-1-mattbobrowski@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26086 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/29/2026 2:01 PM, Matt Bobrowski wrote:
> Centralize the definition of LSM security blob fields using an X-macro
> (LSM_BLOBS_LIST). This reduces repetitive boilerplate code across
> struct lsm_blob_sizes, blob size registration in lsm_prepare(), and
> debug log printing in security_init().
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  include/linux/lsm_hooks.h | 42 ++++++++++++++++------------
>  security/lsm_init.c       | 59 ++++++++++-----------------------------
>  2 files changed, 38 insertions(+), 63 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index b4f8cad53ddb..0e73b22bdeea 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -98,28 +98,34 @@ struct security_hook_list {
>  	const struct lsm_id *lsmid;
>  } __randomize_layout;
>  
> +#define LSM_BLOBS_LIST(X) \
> +	X(cred)          \
> +	X(file)          \
> +	X(backing_file)  \
> +	X(ib)            \
> +	X(inode)         \
> +	X(sock)          \
> +	X(superblock)    \
> +	X(ipc)           \
> +	X(key)           \
> +	X(msg_msg)       \
> +	X(perf_event)    \
> +	X(task)          \
> +	X(tun_dev)       \
> +	X(xattr_count)   \
> +	X(bdev)          \
> +	X(bpf_map)       \
> +	X(bpf_prog)      \
> +	X(bpf_token)
> +
>  /*
>   * Security blob size or offset data.
> + * Note: lbs_xattr_count is the number of xattr slots in new_xattrs array.
>   */
>  struct lsm_blob_sizes {
> -	unsigned int lbs_cred;
> -	unsigned int lbs_file;
> -	unsigned int lbs_backing_file;
> -	unsigned int lbs_ib;
> -	unsigned int lbs_inode;
> -	unsigned int lbs_sock;
> -	unsigned int lbs_superblock;
> -	unsigned int lbs_ipc;
> -	unsigned int lbs_key;
> -	unsigned int lbs_msg_msg;
> -	unsigned int lbs_perf_event;
> -	unsigned int lbs_task;
> -	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
> -	unsigned int lbs_tun_dev;
> -	unsigned int lbs_bdev;
> -	unsigned int lbs_bpf_map;
> -	unsigned int lbs_bpf_prog;
> -	unsigned int lbs_bpf_token;
> +#define LSM_BLOB_SIZE(name) unsigned int lbs_##name;
> +	LSM_BLOBS_LIST(LSM_BLOB_SIZE);
> +#undef LSM_BLOB_SIZE
>  };
>  
>  /*
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7c0fd17f1601..c256f1c33efa 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -282,40 +282,24 @@ static void __init lsm_blob_size_update(unsigned int *sz_req,
>   * lsm_prepare - Prepare the LSM framework for a new LSM
>   * @lsm: LSM definition
>   */
> -static void __init lsm_prepare(struct lsm_info *lsm)
> +static void __init lsm_prepare(const struct lsm_info *lsm)

This is an unrelated change which should be in a separate patch.

>  {
>  	struct lsm_blob_sizes *blobs = lsm->blobs;
>  
>  	if (!blobs)
>  		return;
>  
> -	/* Register the LSM blob sizes. */
> -	blobs = lsm->blobs;
> -	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> -	lsm_blob_size_update(&blobs->lbs_backing_file,
> -			     &blob_sizes.lbs_backing_file);
> -	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> -	/* inode blob gets an rcu_head in addition to LSM blobs. */
> +	/* The inode blob (inode->i_security) gets an rcu_head in addition to
> +	 * LSM blobs.
> +	 */

Please retain the comment style of the file. Either
	/* ... */
	/*
	 * ...
	 */
but not
	/* ...
	 */

>  	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
>  		blob_sizes.lbs_inode = sizeof(struct rcu_head);

This is where I dislike the macro approach. While this particular
exception is easily handled, others may not be. A blob whose size
isn't represented as an unsigned int (e.g a bool) would not use
lsm_blob_size_update(). While all of the existing blob sizes are
unsigned ints, I have considered bools on more than one occasion.

> -	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
> -	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_blob_size_update(&blobs->lbs_perf_event,
> -			     &blob_sizes.lbs_perf_event);
> -	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_blob_size_update(&blobs->lbs_superblock,
> -			     &blob_sizes.lbs_superblock);
> -	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
> -	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_blob_size_update(&blobs->lbs_xattr_count,
> -			     &blob_sizes.lbs_xattr_count);
> -	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
> -	lsm_blob_size_update(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
> -	lsm_blob_size_update(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
> -	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
> +
> +	/* Register the LSM blob sizes. */
> +#define UPDATE_LSM_BLOB_SIZE(name) \
> +	lsm_blob_size_update(&blobs->lbs_##name, &blob_sizes.lbs_##name);
> +	LSM_BLOBS_LIST(UPDATE_LSM_BLOB_SIZE);
> +#undef UPDATE_LSM_BLOB_SIZE
>  }
>  
>  /**
> @@ -441,25 +425,10 @@ int __init security_init(void)
>  		lsm_prepare(*lsm);
>  
>  	if (lsm_debug) {
> -		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
> -		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
> -		lsm_pr("blob(backing_file) size %d\n",
> -		       blob_sizes.lbs_backing_file);
> -		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
> -		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
> -		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
> -		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
> -		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
> -		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
> -		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
> -		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
> -		lsm_pr("blob(task) size %d\n", blob_sizes.lbs_task);
> -		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
> -		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
> -		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
> -		lsm_pr("blob(bpf_map) size %d\n", blob_sizes.lbs_bpf_map);
> -		lsm_pr("blob(bpf_prog) size %d\n", blob_sizes.lbs_bpf_prog);
> -		lsm_pr("blob(bpf_token) size %d\n", blob_sizes.lbs_bpf_token);
> +#define PRINT_LSM_BLOB_SIZE(name) \
> +	lsm_pr("blob(" #name ") size %d\n", blob_sizes.lbs_##name);
> +		LSM_BLOBS_LIST(PRINT_LSM_BLOB_SIZE);
> +#undef PRINT_LSM_BLOB_SIZE
>  	}
>  
>  	if (blob_sizes.lbs_file)
