Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854962DCF55
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429851; cv=none; b=r2glcnlAuxld1mvh+oq3tsBdQ1WhkmZ8eGLB5fwKGPeZaRkBf0Df2Z8RyWomrlpSx1DRLTA1eBvpMQGYd658OXGalWA2RsevFqC8T45gZs7ac0jtTzA5v8LVJ56CpTzeHnIsAsDvIwBgHC4jI6L/v5pvwjWYaGXHPu2sD6IVeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429851; c=relaxed/simple;
	bh=kQivr15O4EVZip7LB2IjW1BBZ9SfkLZfJmsFTZUgxNM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XGPyxq3x+Ub7m2k+5GwcjpcxWg0B1TWmxMXgUFfkuefqB7OV3p1B9wYe09Fxll1eEvOx7Mx8DH8qeoosTpiOm2aL4VzumUjfZREtdULwSZvf1fYoovvifsUh8cpQtSvw3GBv3IxALqKsdTvUWh+ge5FNxVn5JogCwLhT0nqSpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tDmvAbsI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tDmvAbsI"
Received: from narnia (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id A150920B7167;
	Tue,  2 Jun 2026 12:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A150920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780429835;
	bh=ZXi4q2oPSKkQp6Lv8uO4DbhPrgaaQ4XOPeuPVq0tpmA=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=tDmvAbsInwVUHZSPfn6Z+bheEGpXc1VGVt6uQ6Phx0tpmMVCBh9mIw3lx73/tj6aF
	 aQ5s4PMeNlGWFC6GoQwCx/AbBQ7bvhXXqH0QAQvxT2HZw/T8Mw1vp7Gztn958BWqwu
	 LRfCrWyhki9NhsqqTE0p7IAOWZDaNe6EsGcdmnEs=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] hornet: adjustments for the updated
 bpf_map_ops::map_get_hash() API
In-Reply-To: <20260602183658.161744-2-paul@paul-moore.com>
References: <20260602183658.161744-2-paul@paul-moore.com>
Date: Tue, 02 Jun 2026 12:50:47 -0700
Message-ID: <87ldcwyb54.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Moore <paul@paul-moore.com> writes:

> Commit c48c3a7e7d5b ("bpf: Drop redundant hash_buf from map_get_hash
> operation") changed the map_get_hash() API to only take a single
> parameter, the bpf_map instance; this commit updates the Hornet code
> accordingly.
>
> Beyond the basic map_get_hash() usage change, this commit also removes
> the remaining SHA-256 specific code from Hornet, instead relying on the
> size of the bpf_map::sha field to determine the appropriate digest size.
> While Hornet remains tied to SHA-256 because it is hardcoded into the
> BPF subsystem, the Hornet code itself should now be fairly agile with
> respect to hash algorithms.  The only area where Hornet does appear to
> hardcode a hash algorithm is in the MAP_DIGEST_SIZE macro where the
> bpf_map::sha field is referenced, but that is purely a field name and
> if the BPF subsystem changes the name to something more generic it will
> be easily caught and corrected at build time.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/hornet/hornet_lsm.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> index eeb422db1092..a1cb2e130323 100644
> --- a/security/hornet/hornet_lsm.c
> +++ b/security/hornet/hornet_lsm.c
> @@ -17,16 +17,17 @@
>  #include <linux/sort.h>
>  #include <linux/asn1_decoder.h>
>  #include <linux/oid_registry.h>
> +#include <linux/stddef.h>
>  #include "hornet.asn1.h"
>  
>  #define MAX_USED_MAPS 64
>  
> -/* The only hashing algorithm available is SHA256 due to it be hardcoded
> - * in the bpf subsystem.
> - */
> +/* Use the hash alg hardcoded into the bpf subsystem, currently sha256 */
> +#define MAP_DIGEST_SIZE (sizeof_field(struct bpf_map, sha))
> +
>  struct hornet_prog_security_struct {
>  	int signed_hash_count;
> -	unsigned char signed_hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
> +	unsigned char signed_hashes[MAP_DIGEST_SIZE * MAX_USED_MAPS];
>  };
>  
>  struct hornet_parse_context {
> @@ -60,12 +61,12 @@ int hornet_map_hash(void *context, size_t hdrlen,
>  {
>  	struct hornet_parse_context *ctx = (struct hornet_parse_context *)context;
>  
> -	if (vlen != SHA256_DIGEST_SIZE && vlen != 0)
> +	if (vlen != MAP_DIGEST_SIZE && vlen != 0)
>  		return -EINVAL;
>  	if (ctx->security->signed_hash_count >= MAX_USED_MAPS)
>  		return -EINVAL;
>  
> -	memcpy(&ctx->security->signed_hashes[ctx->security->signed_hash_count * SHA256_DIGEST_SIZE],
> +	memcpy(&ctx->security->signed_hashes[ctx->security->signed_hash_count * MAP_DIGEST_SIZE],
>  	       value, vlen);
>  
>  	return 0;
> @@ -188,7 +189,6 @@ static int hornet_bpf_prog_load_integrity(struct bpf_prog *prog, union bpf_attr
>  static int hornet_check_prog_maps(struct bpf_prog *prog)
>  {
>  	struct hornet_prog_security_struct *security;
> -	unsigned char hash[SHA256_DIGEST_SIZE];
>  	struct bpf_map *map;
>  	int i, j;
>  	bool found;
> @@ -209,12 +209,12 @@ static int hornet_check_prog_maps(struct bpf_prog *prog)
>  			if (!READ_ONCE(map->frozen) || !map->ops->map_get_hash)
>  				continue;
>  
> -			if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash))
> +			if (map->ops->map_get_hash(map))
>  				continue;
>  
> -			if (memcmp(hash,
> -				   &security->signed_hashes[i * SHA256_DIGEST_SIZE],
> -				   SHA256_DIGEST_SIZE) == 0) {
> +			if (memcmp(map->sha,
> +				   &security->signed_hashes[i * MAP_DIGEST_SIZE],
> +				   MAP_DIGEST_SIZE) == 0) {
>  				found = true;
>  				break;
>  			}
> -- 
> 2.54.0

Acked-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
