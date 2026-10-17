Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95738F636
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223364; cv=none; b=mXcMffv9FaIqnucMnutRw3PxOgsDFE1W7NHka4yHy3uiKikZPz0uiUxoi/DP9eenfGkMa2tiWT5fatCpbbXU5vRrX5l9qJf2Rr0ewEI4pnI7tQXFGqwAECJ55vnJT6EWbZ5r8ljlz18m8EbEEVu1gUI2sIU84HxFTXF8zKmka/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223364; c=relaxed/simple;
	bh=q1FeLJyp/npmf+8ffDfR/rgG1AmSVf/75lqdBVEQoIs=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RlT0E3/l16Q3axTSxnd8rWiZJanjoG9y/lxX0Y/SK+KkS/z/nbo01Gy1v6DYV2rm5vjsj43nExg8lIzAdeHIiCmltt9rrW9uBb06M4V8lnfDBKSTZ3GOiNfiI56yummvLTqHdox1HtgfzQaUO2aHBh64Rn2g5uhVgir+aJTDgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRwsAWRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRwsAWRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866AD1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 07:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792223362;
	bh=L2vbGmhabE1G4kOhsVfUiPUDIGY/qR8juAnVHrmbZrw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IRwsAWRFzwuRJLpy1K77NcCZFzSgX3e2b53yv731RDPdp8soJg5tGVqlIqgtQYtSX
	 QxHW4SGZYjxSOUg3nmTjs8IiHeT9K+nSLSqZQ9LQk+7tIe3MI2iP6sO7dnAtLi/vMQ
	 Vkayb3nzyYvrHsUclC1SYwuP7Yyz1BkUnL19/btqsg71HuQEKZ2QgiAc4ySmu/BfvT
	 JfiCp19jfCp0kBukBPo5FciWNpwpS5KafBoVqvjUput7joXcWKbkTb6ZUn5qGc43zd
	 /gr5Ao9ZaXaR6PQ3videZT1UUalo43CFBv5pho+h1SEKMCZ20za1gOKqlHm5lR9sa0
	 1bmfXKXnTNrQw==
Message-ID: <sashiko-outbox-175373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: Protect the read method check against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com>
References: <pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 07:49:22 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] keys: lockdep class use-after-free in keyctl_read_key() after ty=
pe unload
--

commit 74db11a8500db2209c8e5cbb82e05cfc4e6396ee
Author: Cen Zhang <zzzccc427@gmail.com>

keys: Protect the read method check against type removal

This patch acquires key->sem for reading around the key->type->read check
in keyctl_read_key() so that a concurrent module unload and key garbage
collection pass cannot free the key type before the read pointer is
inspected.

> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d14ace88e529c..43a5a3c4d1352 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -861,10 +861,13 @@ long keyctl_read_key(key_serial_t keyid, char __use=
r *buffer, size_t buflen)
> =20
>  	/* the key is probably readable - now try to read it */
>  can_read_key:
> -	if (!key->type->read) {
> -		ret =3D -EOPNOTSUPP;
> +	down_read(&key->sem);
> +	ret =3D -EOPNOTSUPP;
> +	if (key->type->read)
> +		ret =3D 0;
> +	up_read(&key->sem);
> +	if (ret)
>  		goto key_put_out;
> -	}
> =20
>  	if (!buffer || !buflen) {
>  		/* Get the key length from the read method */

[Severity: Medium]
With CONFIG_LOCKDEP enabled, can acquiring key->sem here trigger a
use-after-free on the lockdep class if the key's modular key_type has
already been unregistered and its module unloaded?

When the key is allocated in security/keys/key.c:key_alloc(), key->sem is
bound to the key type's lock_class in the module's data section:

    init_rwsem(&key->sem);
    lockdep_set_class(&key->sem, &type->lock_class);

If a reader task in keyctl_read_key() holds a reference to the key after
lookup_user_key() and is delayed before reaching can_read_key:, a
concurrent module unload can run unregister_key_type() ->
key_gc_keytype() -> key_garbage_collector() in security/keys/gc.c:

destroy_dead_key:
    spin_unlock(&key_serial_lock);
    kdebug("destroy key %d", key->serial);
    down_write(&key->sem);
    key->type =3D &key_type_dead;
    if (key_gc_dead_keytype->destroy)
        key_gc_dead_keytype->destroy(key);
    memset(&key->payload, KEY_DESTROY, sizeof(key->payload));
    up_write(&key->sem);

That down_write(&key->sem) populates key->sem.dep_map.class_cache[0] with
the module's lock_class, and key->type is switched to key_type_dead
without resetting the lockdep class on key->sem. Once
unregister_key_type() returns, free_module() -> lockdep_free_key_range()
-> zap_class() clears the class bit in lock_classes_in_use, sets
class->key =3D NULL, and queues the struct lock_class onto
free_lock_classes.

Previously, if retyping and module unload finished before can_read_key:,
keyctl_read_key() saw key_type_dead.read =3D=3D NULL without taking key->se=
m.
With this change (or in __keyctl_read_key() if the module unloads after
can_read_key:), calling down_read(&key->sem) enters
kernel/locking/lockdep.c:__lock_acquire() with the dangling
key->sem.dep_map.class_cache[0] pointer:

    if (subclass < NR_LOCKDEP_CACHING_CLASSES)
        class =3D lock->class_cache[subclass];
    ...
    if (DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use)))
        return 0;

Could this hit DEBUG_LOCKS_WARN_ON(!test_bit(class_idx,
lock_classes_in_use)) or corrupt lockdep state if the lock_class entry
has been reallocated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-key-management-o=
bjects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com?part=3D1
