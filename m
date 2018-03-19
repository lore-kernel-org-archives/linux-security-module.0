From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 19 Mar 2018 11:47:40 -0400
Subject: Problem mounting pseudo filesystems with SMACK and IMA enabled.
In-Reply-To: <CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
References: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
	<1521206743.3503.29.camel@linux.vnet.ibm.com>
	<CABatt_zxC1W-OirRLM-PVERAkUZaJDSnRDc_i4a7ebh-NJZ9Ag@mail.gmail.com>
	<1521211762.3503.46.camel@linux.vnet.ibm.com>
	<77f5ac13-dd79-abf7-13b2-336bf799a25c@schaufler-ca.com>
	<CABatt_yk_73BsgaD7UsHOL9wse0FxR=i1YXneUfx6aUiBra_JQ@mail.gmail.com>
	<CABatt_zM0Uu2fEwyORKTLYMC2_KeqSkcye1toBxhyjkgOUr62Q@mail.gmail.com>
Message-ID: <1521474460.3503.191.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-03-19 at 14:37 +0000, Martin Townsend wrote:
[...]
> The problem was because systemd couldn't create directories for the
> mounts /dev/shm and /sys/fs/cgroup/systemd, it was returning -ENOKEY.

There's a disconnect between what ima-evm-utils supports and the
kernel. ?This sounds like the kernel you're using has directory
support, which has not been upstreamed.
??
> After investigating it looks like I need to set a key for HMAC to stop
> the mkdir failing which I didn't appreciate I needed with a pre-signed
> image.

> I have a question on this, looking at the IMA code it will try and
> replace my signatures with the HMAC unless the immutable attribute is
> set, is this correct?

EVM will replace the file signature with an HMAC, unless the
filesystem is mounted r/o, is immutable, or is signed with the new EVM
portable and immutable signature.

>  In the evmctl utility there's mention of an evm
> immutable flag but I see nothing in the kernel code that supports
> this. Is this a feature that never made it into the kernel? or is it
> there but I've missed it?

The portable and immutable EVM signature is being added only in this
release (linux-4.16).

> Second question, I have no TPM module so do I need to add a key for
> HMAC or is there another way? It's not a problem if I have to add a
> key I just want to make 100% sure I have to before patching systemd or
> creating my own init process that adds the key before handing over to
> systemd.

systemd already has support for loading an EVM key.

The EVM encrypted key could be based on either a TPM trusted key or a
user key, without the HW guarantees of the private key not being
exposed in the clear. ?If you don't need an EVM key, then without a
TPM, you're probably better off backporting the new portable and
immutable EVM key.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
