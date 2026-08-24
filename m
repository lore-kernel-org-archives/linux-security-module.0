Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680613803C5
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594847; cv=none; b=ldG+NrUQQ2BkSbjePO5AXb2qBK2IOzEe3Hkh6lrI75L2B1t3siJMO+Hkj4hi7dYDll0cqjemAZB62owmuTnYNC/v8vXDW+HSNfA4wJA0QeZS3OEgHmGGDy+kqXR8TxMQwKSCaNWAD85gZycj3EAQOW2SbnhZcJFC78HIWxk6oCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594847; c=relaxed/simple;
	bh=dlaZ3jp4/ZOhlURmlaYrknNPKA+QgM5sxDBg2aDrc6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4G5S2G0bR1cMs98o6z5tCew8T5vRmvjLo8j7RS1VSN4Qh0X40Dl1Fxho+7BNJDFLNyQuGGuvdU7wGzxtTWi6mn9ZB1MShP9j41q20p4G0wIFI2xSsxNx45EdliKyz6a53Aze3myS+vefIfsrN56WTHA11z9A8zjP3IsukvW9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gXK7Zjn3; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gXK7Zjn3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787594843; bh=dlaZ3jp4/ZOhlURmlaYrknNPKA+QgM5sxDBg2aDrc6A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gXK7Zjn3RZgLAubfnVxGdKPgQRwoiEHMJQaAulkIC2HBQx3OPg1VQQl/o7EDJHLg2D878/0QoaqGtNbQfxYu2Q8euJNksEWdF4t7fKUQu6ilxKh+YntzH3041oX+eIpzNhQ5Z2JXAdHNz+5e9ckBj46ZyXpnhu3dGhMU8NLC5N/crd3nBVfZv8qR78sBG1Q5nbYT3lz38R5M+HAv+dKvSh0WnrwKnvybR98OAlv09u4NtzQiHNGCutuNLgZh16biZf/9xCKo+Uwys2hTxV924R7wO3hX1PKDIXECGI5mkTrQm9rMVan82rbFpwVoRSdDD1F/YMWjn7MHlz8AsWruHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787594843; bh=RERKzKI78EvRciBS6XNxPVIzQuZ8JVVp5H0RKh5oKuG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kLIEGPpZ9qaZqnu8Duogh+VpvLxjtkS+Mu1xGnwld17Mb4G3h8Ww+h5a3o/EzzSuivf8Cz0Do1KCKMuZ643SXz7Uz9GUad6VvG47sn+1HAujPk2QHpT6qtdz3Kr+5RZm1pvLE2du3NjNPh0lEeKUYLlSulLqK1syWDxAvavNQuXJnPadpS94tPYu1cEb5HHgu9eYsC9gmWy45HGCPRMKswFM0wljhh9YHyPBpXbHmFYBBdMfj1XPWOfpN53EJmgN8rZ3BSI24jun/aokjkuchmfByK8HDKsPCiI3+5RgZIk+YXJsK+e8JpCHuXfZ/pzVLI40XquRFZTQO5G1knm/7w==
X-YMail-OSG: .BxY6fMVM1nfrrKZ2gGbAnxL7A4Czkump3wWVFMvsD1mwiS_dRY3v6e75OpEPLj
 g7frg5l0koKfKBLlhmRlJS5bkNsItoT9XBWFdizUdyrdwHcNhqlrd0.nOXnYjr9i4L_LU74iijPG
 cakRGP83w3LzK8aqi2kYNrBwXNMfAJaQCUJ6TCIeclGuJsZGDx8sXDVX5vrN7G98LiSO9G1tzIo5
 SDT0p4JQjt.TDzGcUv7yAzpHh_kgTUx6bQyTCF_EvgcJCpG_ldLgjON_koikTC5gV4P2jqw_rCTG
 qaqus_IpTCfN7pyMr_jiMg7gzMnJh8AIJIV7zCSgkMucMGz8b39v4eQqP7zhANQKIAW.bz9Q9dPh
 YSy3ZGRpZzYwMBTNVOlzwBCWKVqyogkfkDP6FE5fckR7NlWpI96LCY6dplkmo90vgWbEgCqGUhs9
 QzgGv6CGZwS78yR79PHlP6W36ZK.sPz9vav8tDFqQV.fzMDRb6QgLbAWZ3C6Syv1Ex66k23OgBTk
 YfaQmN3i2myKxwlQFMn33AYf46ADPXn.KjpkpG_BhZ4nkCHRsYANUNSETloyuWxIMgqlNbt.7aSd
 wr4LoM3DTsLQq3UbxjDHL2d8BoCdq1QUI0AQGwurPEBBuhH75F38J_Rzv07SUPQZWM.TdQBitIuk
 Kl1ZZXl6N_LZ2cj2IR2APfWyMGkAwWzV2XOK0UdticcqYVjHZaH8fT.GxXwUXrxbyeimvkb_QdE3
 CUFCU25lG4inSYdd_cFbqRqkMfFxrHUtsr8Q69fyFGGQehTXLRULNK0jhSVe2oK2xpy52ASpUtKu
 gRj5_8IMuTN6H46oQmTpw_jp6Hehjesw2IdXnk22VhGbAAdc2IzXWp8Tw1MYl0eAxfu9.r4HWSVl
 QGo_ted7Xs5fMBNEubD.sNcEuu3Gmse3pOcBdRxAr7gEyjsoWKO1CC5dOu3ubiZries5YgQz_kZ4
 lkli6uad1gaa0il8m7Cuze6iVwC_8Ucs5C3qZuCSrpOEynf01smIedoE98fqDjSKPdcf9znpkUNZ
 F3LlVZvzNrnDaS_nnPW0ptDFYSJ8myUBJngidBI3nRxPeUO_Atrmuk.h9Sdnk3PMNWhvIcIHlAo0
 hKO6OL5VHGNX7ioFT_Jsf74qDFCvAHIB3GP2AFzocHqyAEb0jZDFjjDwz4vHdj7197UqXhSmXJbp
 2l3Hc0aobrJeGw98QIsh7RVGSC5aVmwesk2odItCO07IuoQVjWPlxszao6Uy97aFYY_swSKQv4nw
 K0ohzjjd2lSojSpK17xlUgQ2gZ107_YgWgxwpJ7wooNZZ5sCBe3JDhj.IqLVvCC9q_F7Mww8EMRB
 hR9SnmbhbWol8NFOnFfmcxdo.WP02ijdjvuau2A5TYHMD7s0LHgVKJyQMKoY5VWxBINkaFDhqgsl
 IwbhrIvkSg0QD6UHlOwOjzDV48NaY6rlZ_jLkz8sqXIDhZUzCC6fdPT2y5psNA9qBAXGHccJ2AT8
 U2uWD8blBWW58CuTsVO.a5QFuwvhVZVsHG2lp.g9vx3RzjllNdQuF16vRW1Sj0v79sYeWbPPxy_X
 iVr89ZyNdWkL.24sHoVh7dC5TkROwab53Jw0YwmFnIjf8b6W1WmJT3zDo1mfrHqC_6OuseVKLvcB
 Kt9P6MbIvvXblqemL1eoFngyn9_p.HuSz07a.3TVcoyD3MuZEnxaNlEiCsVe1lU2pJWgBhLWvlWB
 2tTOgySLkBIqpmpoz1B9kWAzX_Goo1a3sHhRAYiGVeIuGqJUg_mxtVEtdvX9NcxSPU5JET136ubl
 2hz_eEZvN5hGMeu7PUaktlf3Ypwpys2CWjnzuMqr9FKFlnCMBtid_SisYwNT.BdIxteEOrNjBCfo
 9PAvCFlBOV.amXmHu5JfenKv_Jhf4QIK9w0n8mQER0gbHTpXnYdlqLZd7TM4rNRPcG_MhWLCiDa2
 DsZqrYarSomVP6ypIO7SzUDF1PngwH2QUhSgmGRk0urnEvNS5YQdez_aeSfahdtVfYdlE4PZ7TuH
 p66ZN65xf.lO071sal9wwkUmUCIE.qChFNeTEtd2Mh49hQkSgCORlBxurdSW91tfsSDjnPHa9bRZ
 qpXcc95LQmJX5FE8PCj7QmrVU0EriKfwnPyblXvHt_sHltzppOnJBrlv7PRH1Y0lMqmI_Sua3XxJ
 M7rz9XvG0kci6we_j.fm_PvlpL.cKewXqoQLCaQdv84ihRozHyw5IW5PxN31E9MaoAFHJgIwbIyg
 7GCmvB5qEh4cShZnDkiuh60kwKKUHh3.Xpm0rn4DOyQqHRauKS3DJG_kttGFXZaBhtxqgHSlzqSi
 oRNSXNM7xA9DN
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 03a1782e-ca32-424b-b4bc-b72e5b7f3a72
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Aug 2026 18:07:23 +0000
Received: by hermes--production-gq1-678d9dd684-vr75x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 511295430bc6cab528e7dc564201e0c9;
          Mon, 24 Aug 2026 17:57:06 +0000 (UTC)
Message-ID: <d97a736c-98f3-4576-9220-e20cb0a84889@schaufler-ca.com>
Date: Mon, 24 Aug 2026 10:57:04 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUkZDIFBBVENIIDAvM10gc21hY2s6?=
 =?UTF-8?Q?_add_file_label_preserve_mechanism?=
To: Tang Peter <Peter_Towne@hotmail.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "gaolong@yhkylin.cn" <gaolong@yhkylin.cn>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <TY0PR06MB49571F55B361203419222EDA81A62@TY0PR06MB4957.apcprd06.prod.outlook.com>
 <d0cf31df-05e6-4d77-b6a0-ce6c2c7c009d@schaufler-ca.com>
 <TY0PR06MB495733D0FB097FB83F8E707981A42@TY0PR06MB4957.apcprd06.prod.outlook.com>
 <263920dc-392c-4a95-b7be-05de0e03f447@schaufler-ca.com>
 <TY0PR06MB4957E1715F84D092A7B69CD481A02@TY0PR06MB4957.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <TY0PR06MB4957E1715F84D092A7B69CD481A02@TY0PR06MB4957.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26380 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/24/2026 2:08 AM, Tang Peter wrote:
> Subject: smack: preserve whitelist for the FAT32 copy problem (question)
>
> Hi Casey,
>
> I have a question about a device-side change I've been working on, driven
> by a concrete FAT32 problem, and I'd value your read on what I'm still
> missing.
>
> The problem: FAT32 has no xattr support, so the only way to label files on
> a USB stick is the mount-time default (mount -o smackfsdef=USB_Area). That
> labels files while they are on the stick, but the moment a file is copied
> off the stick onto the root filesystem, the copy inherits the copying
> process's label — the USB_Area provenance is silently lost, and an
> "untrusted" file can end up with an executable label.
>
> I understand transmute is the intended tool, and it does cover copying
> into a quarantine directory. But on this device the destination isn't
> fixed — the application may land the copy in a variety of directories, so
> I can't rely on a transmuting directory always being in the way.
>
> What I ended up with is a preserve variant gated by a whitelist: only a
> small set of untrusted-channel labels (USB / network / serial) is
> preserved
> on copy; everything else keeps the normal process-label behavior. I'm
> aware
> of the write-down this still carries — the whitelist narrows the
> target but
> doesn't remove the primitive — and in this deployment it isn't reachable
> (the only subject that can read the sensitive label is the trusted admin,
> and the operator doing the copies has no read access to it).
>
> My question: apart from that write-down, which I accept as a device-side
> tradeoff, what other problems do you see in this whitelist approach?
> And is
> there a Smack-native mechanism for the FAT32 "label doesn't survive the
> copy" case that I'm still overlooking?

Did you investigate the SMACK64_EXEC solution I suggested?
Unless you want to copy to arbitrary locations with a variety
of labels it should address the issue.

>
> This is not a merge request — I'm asking to make sure I understand the
> space before I ship it. If it helps to see the exact diff for reference,
> I can send it.
>
> Thanks,
> Tang Pengke
> ------------------------------------------------------------------------
> *发件人:* Casey Schaufler <casey@schaufler-ca.com>
> *发送时间:* 2026年8月21日 4:11
> *收件人:* Tang Peter <Peter_Towne@hotmail.com>
> *抄送:* linux-security-module@vger.kernel.org
> <linux-security-module@vger.kernel.org>; gaolong@yhkylin.cn
> <gaolong@yhkylin.cn>; Casey Schaufler <casey@schaufler-ca.com>
> *主题:* Re: 回复: [RFC PATCH 0/3] smack: add file label preserve mechanism
>
>  
> On 8/20/2026 5:05 AM, Tang Peter wrote:
> > Subject: Re: [RFC PATCH 0/3] smack: add file label preserve mechanism
> >
> > Hi Casey,
> >
> > Thanks again for the earlier guidance. I've dropped the preserve
> mechanism
> > as discussed — the ecp example made the write-down flaw clear.
> >
> > Let me restate the concrete problem I'm still trying to solve, because
> > it is
> > narrower than the original patch and I want to check whether there is a
> > cleaner native mechanism I'm overlooking.
> >
> > Context: I'm designing a channel-classification scheme for an embedded
> > device (MIPS, BusyBox) where incoming files are labeled by origin — USB,
> > network, and serial each map to an untrusted label (USB_Area, Net_Area,
> > Serial_Area). The design goal is that a file's label encodes where
> it came
> > from, so it stays traceable through its lifetime.
> >
> > The specific gap is FAT32 USB. FAT32 has no xattr support, so per-file
> > labels can't be stored on the stick. The only way to label stick
> > content is
> > the mount-time default:
> >
> >     mount -t vfat -o smackfsdef=USB_Area /dev/sda1 /mnt/usb
> >
> > which makes every file on the mount appear as USB_Area. That part works.
> > The problem is the moment content leaves the stick: `cp /mnt/usb/f.txt
> > /srv/data/f.txt` creates f.txt with the copying process's label, so the
> > USB_Area provenance is silently lost.
> >
> > From your earlier reply I understand transmuting labels are the intended
> > tool, and indeed copying into a transmuting quarantine directory
> preserves
> > the label — our ingress path already does exactly that. The case I can't
> > close is the later approval step: when an administrator moves a file
> > out of
> > the quarantine into a normal data directory, the label is lost again
> > unless
> > the administrator relabels explicitly.
> >
> > So the question is narrower than preserve: is there an established SMACK
> > pattern for "a file that originated on a smackfsdef mount keeps that
> > provenance across a copy or move", beyond explicit chsmack at every
> step?
>
> How about trying a special program cp_usbarea which uses a SMACK64_EXEC
> attribute to always run with your USB_Area label? You would need a rule
>
>         USB_Area <label-of-destination> rw
>
> to allow the program to write in the destination directory. cp_usbarea
> would need to be trusted to some level, but not to the extent a root
> or CAP_MAC_ADMIN process would require.
>
> >
> > I currently solve it in userspace (a small cp wrapper that copies the
> > source
> > label with chsmack after the copy, which works because chsmack is
> > privileged), but I'd rather not invent a mechanism if SMACK already
> > has one
> > for this case.
> >
> > Thanks for your time.
> >
> > Regards,
> > Tang Pengke
> > ------------------------------------------------------------------------
> > *发件人:* Casey Schaufler <casey@schaufler-ca.com>
> > *发送时间:* 2026年8月19日 0:11
> > *收件人:* Tang Peter <Peter_Towne@hotmail.com>
> > *抄送:* linux-security-module@vger.kernel.org
> > <linux-security-module@vger.kernel.org>; Casey Schaufler
> > <casey@schaufler-ca.com>
> > *主题:* Re: [RFC PATCH 0/3] smack: add file label preserve mechanism
> >  
> > On 8/18/2026 1:05 AM, Tang Peter wrote:
> > > Subject: [RFC PATCH 0/3] smack: add file label preserve mechanism
> > >
> > > Hi Casey,
> > >
> > > I'm working on an embedded Linux device (MIPS, BusyBox) that uses
> SMACK
> > > for mandatory access control, and I ran into a problem that I think is
> > > worth your opinion on.
> > >
> > > Problem
> > > -------
> > > When a user copies a file with BusyBox cp, the destination file
> inherits
> > > the *process* label rather than the *source* file's label.
> >
> > This is the correct and expected behavior. A process that creates
> > a new file has the opportunity to put whatever data it desires in it,
> > so the new file has to have the process label, regardless of any
> labeling
> > of the source information.
> >
> > Cases like this are why Smack has transmuting labels. Without more
> > information
> > about the specifics of your directory hierarchy and labeling
> strategy it's
> > hard to offer specific advice, but if what you have is a limited set
> > of files
> > that require label preservation you should be able to use that
> mechanism.
> >
> > >  On desktop or
> > > server systems this is solved in userspace -- GNU cp has
> > > --preserve=context, and SELinux has restorecond. But on an embedded
> > > device with BusyBox, neither is available, and the result is that the
> > > source file's label (e.g. an untrusted "USB" label) is silently lost
> > > after the copy, which breaks both access control and audit tracing.
> > >
> > > Proposed mechanism
> > > ------------------
> > > An opt-in "preserve" feature controlled via /sys/fs/smackfs/preserve
> > > (default off):
> > >
> > >   1. smack_file_open(): when a regular file is opened O_RDONLY,
> > >      record its label into task_smack::smk_preserve. Shared library
> > >      loads under /lib/ and /usr/lib/ are skipped (path-prefix filter)
> > >      so ld.so does not pollute the preserve slot.
> > >
> > >   2. smack_inode_init_security(): if smk_preserve is set, use it as
> > >      the new inode's label and clear it. TRANSMUTE still takes
> > >      priority, so existing transmuting-directory behaviour is
> unchanged.
> > >
> > >   3. The slot is one-shot: cleared on use, on fork (cred_prepare),
> > >      and on exec (bprm_creds_for_exec), so it only applies to a
> > >      "read then create" sequence within a single process.
> > >
> > > This makes `cp a b`, `cat a > b`, and similar BusyBox workflows keep
> > > the source label without any userspace changes.
> >
> > I have an evil program "ecp", which uses this mechanism. ecp opens a
> > file labeled "_", and creates a new executable file /bin/xyzzy. It then
> > opens a file labeled "somethingelse", which contains a malicious
> program.
> > /bin/xyzzy is filled with the malicious program. Now, processes that
> > have no access to somethingelse are exposed to the malicious program.
> >
> > You could restrict smk_preserve to programs with CAP_MAC_ADMIN, but
> > such a process could relabel the file directly, rendering the mechanism
> > unnecessary.
> >
> > >
> > > Questions
> > > ---------
> > > - Does this approach make sense for SMACK, or is there an existing /
> > >   preferred way to solve this that I've missed?
> > > - Any concerns about the one-shot slot semantics, or the /lib/ filter?
> > >
> > > Thanks,
> > > Tang Pengke
> > >
> > > ---
> > >  security/smack/smack.h     |  2 ++
> > >  security/smack/smack_lsm.c | 45
> > > +++++++++++++++++++++++++++++++++++++++++----
> > >  security/smack/smackfs.c   | 50
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 93 insertions(+), 4 deletions(-)
> > >
> > >
> > > From: Tang Pengke <peter_towne@hotmail.com>
> > > Subject: [RFC PATCH 1/3] smack: add smk_preserve field to task_smack
> > >
> > > Add a smk_preserve pointer to struct task_smack for recording
> > > the label of the last file opened read-only. Also declare the
> > > global smack_preserve toggle variable.
> > >
> > > Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> > > ---
> > >  security/smack/smack.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > > index 8ad30955e15..c6eea57cf52 100644
> > > --- a/security/smack/smack.h
> > > +++ b/security/smack/smack.h
> > > @@ -124,6 +124,7 @@ struct task_smack {
> > >       struct list_head  smk_rules;  /* per task access rules */
> > >       struct mutex            smk_rules_lock;   /* lock for the
> rules */
> > >       struct list_head  smk_relabel;      /* transit allowed labels */
> > > +     struct smack_known      *smk_preserve;    /* label to preserve
> > > on create */
> > >  };
> > >  
> > >  #define    SMK_INODE_INSTANT 0x01  /* inode is instantiated */
> > > @@ -325,6 +326,7 @@ extern struct smack_known *smack_unconfined;
> > >  #endif
> > >  extern int smack_ptrace_rule;
> > > +extern int smack_preserve;
> > >  extern struct lsm_blob_sizes smack_blob_sizes;
> > >  
> > >  extern struct smack_known smack_known_floor;
> > >
> > >
> > > From: Tang Pengke <peter_towne@hotmail.com>
> > > Subject: [RFC PATCH 2/3] smack: implement file label preserve
> mechanism
> > >
> > > When smack_preserve is enabled, opening a regular file read-only
> > > records its label in task_smack::smk_preserve. On the next file
> > > creation (smack_inode_init_security), that label is applied to the
> > > new inode -- unless TRANSMUTE takes priority.
> > >
> > > The preserve is one-shot:
> > >   - Consumed immediately on new inode creation
> > >   - Cleared on fork (smack_cred_prepare)
> > >   - Cleared on exec (smack_bprm_creds_for_exec)
> > >
> > > Shared library loads under /lib/ and /usr/lib/ are explicitly
> > > excluded from recording, so ld.so does not pollute the preserve
> > > label during exec. Non-regular files (directories, devices) are
> > > also skipped.
> > >
> > > This enables tools like cp and 'cat > file' to create files that
> > > retain the source file's label, without requiring any userspace
> > > changes. The feature is disabled by default (preserve=0).
> > >
> > > Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> > > ---
> > >  security/smack/smack_lsm.c | 45
> > > +++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 41 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > > index 11f238e94..951c79d9e 100644
> > > --- a/security/smack/smack_lsm.c
> > > +++ b/security/smack/smack_lsm.c
> > > @@ -935,6 +935,7 @@ static int smack_bprm_creds_for_exec(struct
> > > linux_binprm *bprm)
> > >             return -EPERM;
> > >  
> > >       bsp->smk_task = isp->smk_task;
> > > +     bsp->smk_preserve = NULL;
> > >       bprm->per_clear |= PER_CLEAR_ON_SETID;
> > >  
> > >       /* Decide if this is a secure exec. */
> > > @@ -1066,6 +1067,15 @@ static int smack_inode_init_security(struct
> > > inode *inode, struct inode *dir,
> > >             }
> > >       }
> > >  
> > > +     /*
> > > +      * If a preserve label was recorded on file open, use it
> > > +      * for the new inode (unless TRANSMUTE already applied above).
> > > +      */
> > > +     if (tsp->smk_preserve != NULL) {
> > > +           issp->smk_inode = tsp->smk_preserve;
> > > +           tsp->smk_preserve = NULL;
> > > +     }
> > > +
> > >       if (rc == 0)
> > >             if (xattr_dupval(xattrs, xattr_count,
> > >                       XATTR_SMACK_SUFFIX,
> > > @@ -2064,6 +2074,27 @@ static int smack_file_open(struct file *file)
> > >       struct smk_audit_info ad;
> > >       int rc;
> > >  
> > > +     if (smack_preserve && (file->f_flags & O_ACCMODE) == O_RDONLY) {
> > > +           char *buf;
> > > +           const char *path;
> > > +
> > > +           if (!S_ISREG(inode->i_mode))
> > > +                 goto skip_preserve;
> > > +
> > > +           buf = kmalloc(PATH_MAX, GFP_KERNEL);
> > > +           if (!buf)
> > > +                 goto skip_preserve;
> > > +
> > > +           path = dentry_path_raw(file->f_path.dentry, buf,
> PATH_MAX);
> > > +           if (!IS_ERR(path) &&
> > > +               strncmp(path, "/lib/", 5) != 0 &&
> > > +               strncmp(path, "/usr/lib/", 9) != 0)
> > > +                 tsp->smk_preserve = smk_of_inode(inode);
> > > +
> > > +           kfree(buf);
> > > +     }
> > > +skip_preserve:
> > > +
> > >       smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
> > >       smk_ad_setfield_u_fs_path(&ad, file->f_path);
> > >       rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
> > > @@ -2129,6 +2160,7 @@ static int smack_cred_prepare(struct cred *new,
> > > const struct cred *old,
> > >       int rc;
> > >  
> > >       init_task_smack(new_tsp, old_tsp->smk_task, old_tsp->smk_task);
> > > +     new_tsp->smk_preserve = NULL;
> > >  
> > >       rc = smk_copy_rules(&new_tsp->smk_rules, &old_tsp->smk_rules,
> > gfp);
> > >       if (rc != 0)
> > >
> > >
> > > From: Tang Pengke <peter_towne@hotmail.com>
> > > Subject: [RFC PATCH 3/3] smack: add /sys/fs/smackfs/preserve interface
> > >
> > > Expose the smack_preserve toggle via smackfs. Reading returns '0'
> > > or '1'. Writing '0' or '1' toggles the feature (requires
> > > CAP_MAC_ADMIN). Default is disabled (0) so existing systems are
> > > unaffected.
> > >
> > > Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> > > ---
> > >  security/smack/smackfs.c | 50
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > >
> > > diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> > > index a3a55a25360..8379ef73cf2 100644
> > > --- a/security/smack/smackfs.c
> > > +++ b/security/smack/smackfs.c
> > > @@ -62,6 +62,7 @@ enum smk_inos {
> > >       SMK_NET6ADDR      = 23, /* single label IPv6 hosts */
> > >  #endif /* CONFIG_IPV6 */
> > >       SMK_RELABEL_SELF = 24, /* relabel possible without
> > CAP_MAC_ADMIN */
> > > +     SMK_PRESERVE      = 25, /* label preserve on copy */
> > >  };
> > >  
> > >  /*
> > > @@ -2047,6 +2048,53 @@ static ssize_t smk_write_onlycap(struct file
> > > *file, const char __user *buf,
> > >       return rc;
> > >  }
> > >  
> > > +int smack_preserve;
> > > +
> > > +static ssize_t smk_read_preserve(struct file *filp, char __user *buf,
> > > +                         size_t cn, loff_t *ppos)
> > > +{
> > > +     char val[2];
> > > +
> > > +     if (*ppos != 0)
> > > +           return 0;
> > > +
> > > +     val[0] = smack_preserve ? '1' : '0';
> > > +     val[1] = '\n';
> > > +
> > > +     return simple_read_from_buffer(buf, cn, ppos, val, 2);
> > > +}
> > > +
> > > +static ssize_t smk_write_preserve(struct file *file, const char
> > > __user *buf,
> > > +                          size_t count, loff_t *ppos)
> > > +{
> > > +     char data;
> > > +
> > > +     if (!smack_privileged(CAP_MAC_ADMIN))
> > > +           return -EPERM;
> > > +
> > > +     if (*ppos != 0)
> > > +           return -EINVAL;
> > > +
> > > +     if (copy_from_user(&data, buf, 1) != 0)
> > > +           return -EFAULT;
> > > +
> > > +     if (data == '0')
> > > +           smack_preserve = 0;
> > > +     else if (data == '1')
> > > +           smack_preserve = 1;
> > > +     else
> > > +           return -EINVAL;
> > > +
> > > +     return count;
> > > +}
> > > +
> > > +static const struct file_operations smk_preserve_ops = {
> > > +     .read       = smk_read_preserve,
> > > +     .write            = smk_write_preserve,
> > > +     .llseek           = default_llseek,
> > > +};
> > > +
> > >  static const struct file_operations smk_onlycap_ops = {
> > >       .open       = smk_open_onlycap,
> > >       .read       = seq_read,
> > > @@ -2933,6 +2981,8 @@ static int smk_fill_super(struct super_block
> > > *sb, struct fs_context *fc)
> > >             [SMK_RELABEL_SELF] = {
> > >                   "relabel-self", &smk_relabel_self_ops,
> > >                         S_IRUGO|S_IWUGO},
> > > +           [SMK_PRESERVE] = {
> > > +                 "preserve", &smk_preserve_ops, S_IRUGO|S_IWUSR},
> > >             /* last one */
> > >                   {""}
> > >       };
