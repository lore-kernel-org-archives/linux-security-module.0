Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE278F4EB;
	Fri, 10 May 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356863; cv=none; b=bHBaaA3AFuv8pDr4vDQcyVGsHlcQXAkazGhi5FVUZhXw2HuLtCD3Z67aHUHxzV6DXaz7OKwqxVS9K1dZEsYgRrptE/PmAAQqt83BmiUKNOxhfi55lCHP0VEUqnM7MMzBa5kgR1axPMmm4pgMivy9AW9ct11XI8iyf+4RewivqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356863; c=relaxed/simple;
	bh=6oJIOwz7s/7cV31BhrDMsv2hBP3g/dno31tfKfTOzn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcnaRXwPm27vVVieDkPmKrNoccEuRVTwBi/Tw7L/kFxONDmFpKFMZHxvlFScN1YM9w3HyxT4uLKtEdCOBvw2B7dFekSSM7htOEFO4vSm0sF/ofsl/pTCQOZSex+TqmbDO1ECiTnt5YLR6SzVa8gU7cRr5SGtCDPtL0NndiTzTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QNvVkq4Z; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QNvVkq4Z"
Received: from [10.8.193.2] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9DE493F61C;
	Fri, 10 May 2024 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715356858;
	bh=rzLYhCpYA/kYpMQ6NlE0AQIA4o1/VwVmKnxl57bcHbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=QNvVkq4ZB2Nk67IjVF0pDxfxVkpl10UsVN0YakCameBjMfbhwGyerhCbAJApZpeLh
	 cqJWDD/51dLpaPSH9dl+Irb9PtxBMxircn1fWwXxVSozqe37tFUMG9mp/upfxVRQ01
	 HoHBpuGtyFk+dgVGf/CafOvGkYak0d70sNKJUMvm6qEvWQiC4xfGjgxGBi+RJbDuNk
	 GUorEsy7n+5PE5sfH/8d5b8ZCUR2APHLK0YpVbbhhhjB1lz1y0cH55pz7GkwMEjxLO
	 Hkr9smJ2zGsd3b4InsHISiCvRefJ8NRGxib3KYKpSafdQ+3VAv+5CGCMqNsY+tAbRz
	 /KKfxQGcrmFKw==
Message-ID: <5fd1866c-0985-4da6-b820-21a62abb3170@canonical.com>
Date: Fri, 10 May 2024 09:00:51 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix possible NULL pointer dereference
To: Leesoo Ahn <lsahn@ooseel.net>, lsahn@wewakecorp.com
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507161229.4175603-1-lsahn@wewakecorp.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240507161229.4175603-1-lsahn@wewakecorp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/24 09:12, Leesoo Ahn wrote:
> profile->parent->dents[AAFS_PROF_DIR] could be NULL only if its parent is made
> from __create_missing_ancestors(..) and 'ent->old' is NULL in
> aa_replace_profiles(..).
> In that case, it must return an error code and the code, -ENOENT represents
> its state that the path of its parent is not existed yet.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000030
> PGD 0 P4D 0
> PREEMPT SMP PTI
> CPU: 4 PID: 3362 Comm: apparmor_parser Not tainted 6.8.0-24-generic #24
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:aafs_create.constprop.0+0x7f/0x130
> Code: 4c 63 e0 48 83 c4 18 4c 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 45 31 d2 c3 cc cc cc cc <4d> 8b 55 30 4d 8d ba a0 00 00 00 4c 89 55 c0 4c 89 ff e8 7a 6a ae
> RSP: 0018:ffffc9000b2c7c98 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000000041ed RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000b2c7cd8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82baac10
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007be9f22cf740(0000) GS:ffff88817bc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000030 CR3: 0000000134b08000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   ? show_regs+0x6d/0x80
>   ? __die+0x24/0x80
>   ? page_fault_oops+0x99/0x1b0
>   ? kernelmode_fixup_or_oops+0xb2/0x140
>   ? __bad_area_nosemaphore+0x1a5/0x2c0
>   ? find_vma+0x34/0x60
>   ? bad_area_nosemaphore+0x16/0x30
>   ? do_user_addr_fault+0x2a2/0x6b0
>   ? exc_page_fault+0x83/0x1b0
>   ? asm_exc_page_fault+0x27/0x30
>   ? aafs_create.constprop.0+0x7f/0x130
>   ? aafs_create.constprop.0+0x51/0x130
>   __aafs_profile_mkdir+0x3d6/0x480
>   aa_replace_profiles+0x83f/0x1270
>   policy_update+0xe3/0x180
>   profile_load+0xbc/0x150
>   ? rw_verify_area+0x47/0x140
>   vfs_write+0x100/0x480
>   ? __x64_sys_openat+0x55/0xa0
>   ? syscall_exit_to_user_mode+0x86/0x260
>   ksys_write+0x73/0x100
>   __x64_sys_write+0x19/0x30
>   x64_sys_call+0x7e/0x25c0
>   do_syscall_64+0x7f/0x180
>   entry_SYSCALL_64_after_hwframe+0x78/0x80
> RIP: 0033:0x7be9f211c574
> Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d d5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> RSP: 002b:00007ffd26f2b8c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00005d504415e200 RCX: 00007be9f211c574
> RDX: 0000000000001fc1 RSI: 00005d504418bc80 RDI: 0000000000000004
> RBP: 0000000000001fc1 R08: 0000000000001fc1 R09: 0000000080000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00005d504418bc80
> R13: 0000000000000004 R14: 00007ffd26f2b9b0 R15: 00007ffd26f2ba30
>   </TASK>
> Modules linked in: snd_seq_dummy snd_hrtimer qrtr snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq snd_seq_device i2c_i801 snd_timer i2c_smbus qxl snd soundcore drm_ttm_helper lpc_ich ttm joydev input_leds serio_raw mac_hid binfmt_misc msr parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 hid_generic usbhid hid ahci libahci psmouse virtio_rng xhci_pci xhci_pci_renesas
> CR2: 0000000000000030
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:aafs_create.constprop.0+0x7f/0x130
> Code: 4c 63 e0 48 83 c4 18 4c 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 45 31 d2 c3 cc cc cc cc <4d> 8b 55 30 4d 8d ba a0 00 00 00 4c 89 55 c0 4c 89 ff e8 7a 6a ae
> RSP: 0018:ffffc9000b2c7c98 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00000000000041ed RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000b2c7cd8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82baac10
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007be9f22cf740(0000) GS:ffff88817bc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000030 CR3: 0000000134b08000 CR4: 00000000000006f0
> 
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
>   security/apparmor/apparmorfs.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index bcfea073e3f2..01b923d97a44 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1692,6 +1692,10 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
>   		struct aa_profile *p;
>   		p = aa_deref_parent(profile);
>   		dent = prof_dir(p);
> +		if (!dent) {
> +			error = -ENOENT;
> +			goto fail2;
> +		}
>   		/* adding to parent that previously didn't have children */
>   		dent = aafs_create_dir("profiles", dent);
>   		if (IS_ERR(dent))

