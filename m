Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990215;
	b=0SruUDAB3IGrX5QSGP1hpt2oNO1h3Jz9J4KlYXim0Df4h8yN/DN8vXNkBYyGHuX1FTZ3
	 toBZ5/5klbsJmfY16vThkVrIHdg1rswUEqjVyVuSYI3Mj6YtzIolaDtR60Keb2VarAely
	 8yqxrong68yITf35DpfSWA41vd1jM61DJq12YkJcOMhITGzGtacJKpXcHnQq8x0MGDmLR
	 KOACyDVly5MoEOdOLDfCvJ53/Gbe2S/DlTk7iRYNZsB50lzlq6gzqVvIV7Gx0+2spqy2t
	 YrZplyED/3LRK5nlIBXOySVtXGkV7f+zWlvgJXoc4RIXfRoM8n9IbgqxwH1y90vn1Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990215;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UliTkuKSwijkprFnPvplR6mcOQUjgocutB6yCvWNZyo=;
	b=LxSWLaZtbu1VSxVTqe8pTBf5z9SssPr3FKiE2IH8kthJCCnIz8uDoe5rZJcqN+w5nnmy
	 nHtnKZsYF5L/QKoTuhHxewWNsazikbXjnv6kOoaD+09j6ZAA9CYnLoDkQJTLvcPQJrfB2
	 wwtg8qglwG2L7S13Q0FudOJxkmPnOhHvz/YmNgEed+gdPUke2ahJEFAk0XW5cjvRK6tZq
	 tIDE2uYzFMn7O5Yu60I5tHW4tyI2zvXSvfUC0VK0uaKveEDfhMbyrlhXxr7lt0Ljx5GRj
	 jEhj80TOs4X6aKjInszgsSBqyOdwf5jc+hR+8dwq7NVZzLwcb5mu42RCDmuEcS6aDEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772D6082BD1
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 18:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B772D6082BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4c9abc1824so140588666b.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 10:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990213; x=1794595013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UliTkuKSwijkprFnPvplR6mcOQUjgocutB6yCvWNZyo=;
        b=gXqt4QRYgpSjwlOsLIGQJCROQS52UfzM2YYm42EjfotJT+6JeQO/ioM106XOhBm/Df
         Thl5MwLs8p5hi/3nxYDPoiKuVIEl5TkzKwQhe/FSv8Q7vcbeMKelX2gquabrKizuQ0CM
         6RAijH3rw4kdxbQwFDgwTIwFDQoOHUIDAylqxKnBkgTVYV0ADpqEKMfHlttAamQQxDqw
         zvMvLuxQVK/ehNFnzIkIAdaxImgRFLaIKF7EAlcZ9+nk7ouAuSQVVh36XcXR1Di/jiFF
         aGXNUuhMtzHFRq64TSZKu8Wp04knXVJLUZXFbdu3thYnUF3srOut+uKoMrYcvFYVUyGU
         fNeg==
X-Forwarded-Encrypted: i=1; AKwUvBxboC2C1mYsYQu3DncZsg8bNZ0iVPpcv+Remt3eP57LwZ7aGuhq98XOHht0Q6yy8RqVcLG3laG5mNLsm5S3plRjkGxZjqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MLOhiE7UKihoVjRcAvRmO3T4zCBSXz/4yIcmwwE5KCYJLwHi6
	7vX+H1Zg/BNKwr26OEnl8Lvxo1n8D5dKBFHO9UCa+4AKkYda6iF5mLKmeQn9sSrLX7I=
X-Gm-Gg: AYBFou1HNO+MQi0QFiSWqGw6JW0xDCtfhyf2JXUfoEL90IJIdotOAgDEjK1SCXIhPDK
	tqLlLstYzQQN1MVTmRnz/lG4fHeKrmeMJjL4hC55oOtOjVSrwxXWj+FnyMhjkaqOQcz2cyoAiaU
	8wmcqsMVfdgT6a2CUYf+MZemEHO2bmPkh/AHldXAAmIZ7ZPyMgdd2s3cZOcEVfi3yzfZveI43mF
	1T+m+szMohhu0jc/LCBFkIIOlqNWuXHVXxqJqNbYi50xVt+CGBOutLvjfQ7/hLT6NHmp3cLtPu/
	iGiNEfyLtSDkfn4MBhAtoIqXpMJipxJVraeRDKI7pmvts5vArC8L7k1lkcr1RsbMcLkDvC7VJph
	Dwr+m/xVi1Du/PUS+nolJ59uC/T8/Ub4TTC8MwQD1mLCNc9pBb729AFcfT485b3X7ANkarbqgH+
	lmEUVJEtQ+nK83OyAOThT6Ul98CFKTK9pRL3zk82Xx/5xJxJg8NTWtYHJ4MJngOEMQJkOSF8aQc
	xsMIQrp/wJ3ofWV7rV3NakkZ7LzLP3Y0mW/Uq0AotIm5Y/AAo6hEBxbY2BLLkzy8VbL91TMfBWM
	FIx4RS8VDOgRuPEc2SgIsrAcAc5dz4PW0bKyzuYjg/pXqccDuhv2YP8sf/knsDLslWyVjCxDlIU
	FjR9c
X-Received: by 2002:a17:907:728f:b0:c29:f5d8:9c75 with SMTP id a640c23a62f3a-c4d3536d200mr274673666b.36.1793990213113;
        Fri, 06 Nov 2026 10:36:53 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569f518sm98750966b.56.2026.11.06.10.36.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:36:52 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so1265643a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 06 Nov 2026 10:36:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByKBc2eAWf4BRAbVqFC2ovZU/9Qk8Ym081lB+wlk2GHZe/aCjS5RPJkxAHA8D/AyuQfoW+lplhUpo3/8pGFGVX/cdqp6LY=@vger.kernel.org
X-Received: by 2002:a17:907:ea89:b0:c4c:bff4:200c with SMTP id
 a640c23a62f3a-c4d3531f031mr283547466b.32.1793989808075; Fri, 06 Nov 2026
 10:30:08 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029232437.2581640-1-jarkko@kernel.org> <20261029232437.2581640-2-jarkko@kernel.org>
In-Reply-To: <20261029232437.2581640-2-jarkko@kernel.org>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 6 Nov 2026 18:29:56 +0000
X-Gmail-Original-Message-ID: <CAOs+rJVNyJwqp4CR-d_T4GVjNMjgbaDL78_mZCVGGvN1xpd33w@mail.gmail.com>
X-Gm-Features: AclHuK8TGNjpH-aL7rdb3WJ8RwrdjoKcrJ52VddwbSIE-hld3YHoMNkMBO-NFbA
Message-ID: <CAOs+rJVNyJwqp4CR-d_T4GVjNMjgbaDL78_mZCVGGvN1xpd33w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] KEYS: Introduce keyring_is_empty()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, 
	"open list:ASYMMETRIC KEYS" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:DEVICE-MAPPER (LVM)" <dm-devel@lists.linux.dev>, 
	"open list:FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PRO..." <fsverity@lists.linux.dev>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:25=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> Introduce keyring_is_empty() in order to decouple for BPF, dm-verity and
> fs-verity how keyring internally manages the keys.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Ignat Korchagin <ignat@linux.win>

> ---
>  drivers/md/dm-verity-verify-sig.c                      |  2 +-
>  fs/verity/signature.c                                  |  2 +-
>  include/linux/key.h                                    |  1 +
>  kernel/bpf/keys.c                                      |  2 +-
>  security/keys/keyring.c                                | 10 ++++++++++
>  .../selftests/dm-verity/test-dm-verity-keyring.sh      |  2 +-
>  6 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-ver=
ify-sig.c
> index aadcf5e4a47c..cad21e9144ed 100644
> --- a/drivers/md/dm-verity-verify-sig.c
> +++ b/drivers/md/dm-verity-verify-sig.c
> @@ -153,7 +153,7 @@ int verity_verify_root_hash(const void *root_hash, si=
ze_t root_hash_len,
>         if (ret !=3D -ENOKEY && ret !=3D -EKEYREJECTED)
>                 return ret;
>
> -       if (dm_verity_keyring->keys.nr_leaves_on_tree &&
> +       if (!keyring_is_empty(dm_verity_keyring) &&
>             dm_verity_keyring->restrict_link)
>                 ret =3D verify_pkcs7_signature(root_hash, root_hash_len,
>                                              sig_data, sig_len,
> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index 0302a4e506ec..890d33b9d812 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -67,7 +67,7 @@ int fsverity_verify_signature(const struct fsverity_inf=
o *vi,
>                 return 0;
>         }
>
> -       if (fsverity_keyring->keys.nr_leaves_on_tree =3D=3D 0) {
> +       if (keyring_is_empty(fsverity_keyring)) {
>                 /*
>                  * The ".fs-verity" keyring is empty, due to builtin sign=
atures
>                  * being supported by the kernel but not actually being u=
sed.
> diff --git a/include/linux/key.h b/include/linux/key.h
> index c4486e938a06..20ca43f5eab1 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -439,6 +439,7 @@ extern int restrict_link_reject(struct key *keyring,
>                                 struct key *restriction_key);
>
>  extern int keyring_clear(struct key *keyring);
> +bool keyring_is_empty(const struct key *keyring);
>
>  extern key_ref_t keyring_search(key_ref_t keyring,
>                                 struct key_type *type,
> diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
> index bffc356839ac..24e0416abc99 100644
> --- a/kernel/bpf/keys.c
> +++ b/kernel/bpf/keys.c
> @@ -29,7 +29,7 @@ struct bpf_key *bpf_lookup_keyring(void)
>
>         if (!bpf_keyring)
>                 return NULL;
> -       if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
> +       if (keyring_is_empty(bpf_keyring) ||
>             !READ_ONCE(bpf_keyring->restrict_link))
>                 return NULL;
>
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 5281da9d5bf7..ac48d6204915 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -443,6 +443,16 @@ static void keyring_destroy(struct key *keyring)
>         assoc_array_destroy(&keyring->keys, &keyring_assoc_array_ops);
>  }
>
> +/**
> + * keyring_is_empty - Check whether a keyring is empty
> + * @keyring: The keyring to check.
> + */
> +bool keyring_is_empty(const struct key *keyring)
> +{
> +       return READ_ONCE(keyring->keys.nr_leaves_on_tree) =3D=3D 0;
> +}
> +EXPORT_SYMBOL(keyring_is_empty);
> +
>  /*
>   * Describe a keyring for /proc.
>   */
> diff --git a/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh =
b/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> index 1f9601ef22f8..792449d356cf 100755
> --- a/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> +++ b/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> @@ -746,7 +746,7 @@ test_keyring_inactive_when_empty() {
>      log_info "TEST: Verify dm-verity keyring is inactive when sealed emp=
ty"
>
>      # When keyring_unsealed=3D0, the keyring is sealed immediately while=
 empty
> -    # This means it should NOT be used for verification (nr_leaves_on_tr=
ee=3D0)
> +    # An empty keyring should NOT be used for verification.
>
>      log_info "Keyring state (should be empty and sealed):"
>      list_keyring_keys
> --
> 2.47.3
>
>
