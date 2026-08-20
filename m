Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C32BEC4E
	for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256702; cv=none; b=q3Sv60K4PTw4qOdZuO7D8yS8a7p8bljjxDJEypGZwijQaL/1KXX1oRWOrZw183XFdFmW80zWVCtNoiMFaSNoUVZOylffmeNC4CmfzICcY5m4knxjHD0mMLVHn6BnfcMwmVNaulwOkznBaA0enazxcyAipNW4M18uA7GSWivr/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256702; c=relaxed/simple;
	bh=ONraNDtvhrcrBJyDQDWEtADYYJO3PlNPjxWce4DyYSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLFcJ7uQkXYyM7OhmIqhPsBRKD1bb6ZiNzgEeW4ZzT+5+KkbUamm4Lxf1iUcLT9iRtZVjqPNF8NSriLm2OZiMoQ/dfccuWtMWbzOAK0XVHAVLQYh5h60Gi6HdZs52pJUfnhTm2SrT9o3tf+52Y80d21oEw4Xn3Ddt88BWUD2hXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=iOHr8LE6; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iOHr8LE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787256693; bh=LKAxMgYXk1okPVKU89cDmHdCEZYmdTfOpccthLCHsOw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iOHr8LE6CXutXT9XAA+RaU29DwRM/aYvCfnmkQ9H7g4KHdhoQbbWW75TXd9sIEH9FWdkq6wIrAtoElQPsBPABTYwsoT7WzcXDlAoVE+jnC3xGeHGkALXNtbJP6Xn9d5mGaD+IzPrWDxnqGM8KS3iM9LShwUwd7GNg9gVQqvlmdKeUTTOApnEHHxOBfAfXJzBS/72wLjWDPfTtqDD1CCXcUBwnU4Z4FS9Nh2MT6+fHoJd3bAasm+ZoMOrcKuMSDvUSPmwcrJbncI5m5FsONtm+N/MUyE0CW7aiul43CFmDTyAVe8Vg3czUsV2YJnr2yL5L3MTd8fgbPB9Cm+HFTzP/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787256693; bh=qewF7H+1bsGYtEC0hWws8QWW/dLHOChoc00sTFfwQhV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=buuPRjzmNr8r6LzCdESD+p0DUQQtH7k5mUjDMLY2wKvmqJ09wP5nlj6RcaFPvtApmZOXwbmqkNdshvK/lmBvYdYvw7Rtqe9k6ty9XjL/py4Q0Pq4U1DrLkYC8o8Gg2lCDoZt+F8FEdYUb5j0fMEP0ywe9k1Bg9F1x61e7cJxBVUzTrLuvqxnQE5wyPijgElaOLgIGTpAEkjgmvHS5jN8OPr+D6jJzKClmYsdCK1ufXIJBIaek+squR5eHhJ8IXgoRGra3rtKN+D1Bl9pCtUctV9lzJ5tkw5n0mM567/j84GcYET2WPvtnO3SqaATJOz3pHyzMZkPI+KWHHosC7DDtQ==
X-YMail-OSG: N65v92gVM1klr5r8G21Kvg_vEOYVNQe.781Y_J7C_vZjI__wdGQDlRMJwWyRxey
 Aryz2vPbdB6hFI_YNEmmmUoiWnBIJ3g4yJ1nZrOM5h_UnA81tejtsBGeMXyEe_KSnMfwjBKWR8.U
 eoetxO3o9lF49OrtJ65yYTN2Y0wumC8a2LGDxmsQ3x7LN4pkr8BfSw3de4vM4Qs5E0G9ZHdzAiLI
 XnsKvkhq3Md4oAI350IbYMCdJXXaSF7alfAgjPH1IF8kGr48giIAso7BP9dQKIbFm8ZtpRwg_seI
 fWHtVxbmRrLYplunDbf0r.C8Cagaj3x4_B5iQKu2GwBdhYQaNPU.2DSmrTudHvsuEwnAcOvhozi5
 SI2c3owyNkgRicTQ0RKAVLf91_LHC6bRzeWJTFDZc12NQofmAq0ZyKOcSD0FIag5W2kCXzn0iOvw
 lMz9FUKV05zc._ICqtXiYLuAPOK5lK7vYIfYDW1_09Xg8HOoLGKt7zzDwq02JrplNtnJe5yacY5q
 DsyPV.z0ZoKR_yTK5_8AbxOl8iaEcpcac2vcsHOmEzbnRGoqFItu5m8UpjMJQFkldJxOyA09Lg0q
 PfF.c31vrAPBWruvYWoM3nj7mENnv9S6coZcNAu7wO28kFOWb7WvAlxDVT.sPYgQhob94kl21dPX
 VoHa4qkAzAE.jJT6cghZM7pANFrTqSGjJfCkAYEBdOgWpbd5AtzQKiXvUsdxJeLkci1nIy0m_imQ
 e3T0lO60WmABMWKu0oGnOwwsEPWd0V2QIjXzPxJD6R6ZCjlfMs9qjEG2zEExBfyhwn7Xtq2i4UWN
 XRlPrIKfp5PSDCwxgdNoo9j_FC00Qx96g7gvvKLFQf2pnzaK9moWH65GadCXtcNIMxzpdIfJ6xth
 QnpJo20QLKkFo85LYcq_o0GbhKqAbvfl74Wy0n2FJi5Lxg.hQsv8jn0PWsbR_YS1tVrKq76YonWT
 nlCQz8llXkUkR.DzAtOA3VmtFbWwOWbvRs_TebDVrIdL0S5UKJ6XY2uxD0KVJFlZBb1nc53k61wM
 RrfZSmuU9IFthuFUBzL3QoEAXVyTpWkJ1FGdXI9yy0v4o0XAVA1jwqh3y_R0EZ3JzAp10Qw5nk1L
 eJnDMAcs7jfdXKYKFhrxbx5eufmE3jhBTetN1dA.9f9NZHWmQpL4aJEaWnqXezsuqNBtsSpFMaty
 AuUpjw8BPfm09asCjdpGYtUOhoAk3cb2V9kpIHm238RkX_zuEr.X5LX.RCd3MRdpzCgKQsizpe23
 O60.Q0KVuAq0J6zvP5ekdVpU9rfVuvNlFEPvbmAq2ATrYBo1NvLSldEicNfalJdbu3ibPLkWVmT2
 EBqN6eRiWeY6GV7uxzjmaAOykn_oueCnR7yWtY1_9W6MIo8l0ui.sOk6KvXgUMlEnZJxCx1S9Kez
 5waYX0CZYqowkBcV0nDl7k7cPK.oCZsM1sBX_sM4FpeV9rnPH1CKKVMWKbi8WK2qV8VVXC6fVhpT
 iDvRhK0vBOoC31RffqNTzxbXXcKvG0EPR1MqgyrCssBzlkkJtB81Aq8fyT0rs8ZKmyEnLFfnrEr2
 kc0mwuRWdX4eh0cn0fj6JuakEBZxY0Rs.7NQmX1jz8TeelWC56To56G1scInLRD.NqPJ0YwDOFu5
 Dunx05PwdCOCFxWMjNyNl4muwYuv23umVUR1k.aqB6HEWWfyTuGddADvpJjohM8EgE_b5_vWn_fH
 mJ207ADTBoOiQEllS7HrWOkU8P.PLBtZdJ45_PzjgUOurX6CsSsR51eef3FW7MzZcDITQl6G902S
 pBIzUgNpR9zUWHZ30S0jwzJHpv59McntyCBnKd1Nanj5c39PcnKF0QO6kSldgFHjg47aatR5X8eW
 tCQGqNoFPBRzvPvY2B4PJl8lRFKcD72JNXOfbBLV4YVjxQikjtIHQm0jolQt15RLm9xr7sTbclag
 8npnrpbJR.INDYChZALctB4oaLxvHN8CT_msEMzHn_TY44NuObSX4YgIrty1XLw8BXkzXM6WUJ0U
 X.JktpjfVJZ6N4a_fB9NhFpl2mOVQL3CelX.5rJESRiBlK0OGD3DKa2Fn0T5oBuP.Ezeq6mHRM9V
 OOTE4O4WnffVWv_mncQIR.70xxRGFHEush6Mv1HX_rGzZEQkPUddkrtTCiDdGGskp6lUWDZBI3iW
 Lo27L2Enykx.7zmgpOAEObd5ilEyo7vkaQBVjWL3366Dpq.AjZBkCvXEa9sejEaRq.eKME9sBTCb
 fQ49gc97kveGlmBD3aFRqEYIqJVm5q.Ize5jAMmRIFfsxX7QhwBN2tU0pEl3kYPtNKjfivEsKs85
 QPzKDg88ZemEIog--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7b7abb32-675b-4263-bb2f-c0828f7502df
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Aug 2026 20:11:33 +0000
Received: by hermes--production-gq1-678d9dd684-9bnvv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e15d8478b5e4ee55bd5e4b5edeaf1a3b;
          Thu, 20 Aug 2026 20:11:26 +0000 (UTC)
Message-ID: <263920dc-392c-4a95-b7be-05de0e03f447@schaufler-ca.com>
Date: Thu, 20 Aug 2026 13:11:24 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JGQyBQQVRDSCAwLzNdIHNtYWNrOiBhZGQgZmls?=
 =?UTF-8?Q?e_label_preserve_mechanism?=
To: Tang Peter <Peter_Towne@hotmail.com>
Cc: "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "gaolong@yhkylin.cn" <gaolong@yhkylin.cn>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <TY0PR06MB49571F55B361203419222EDA81A62@TY0PR06MB4957.apcprd06.prod.outlook.com>
 <d0cf31df-05e6-4d77-b6a0-ce6c2c7c009d@schaufler-ca.com>
 <TY0PR06MB495733D0FB097FB83F8E707981A42@TY0PR06MB4957.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <TY0PR06MB495733D0FB097FB83F8E707981A42@TY0PR06MB4957.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26254 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/20/2026 5:05 AM, Tang Peter wrote:
> Subject: Re: [RFC PATCH 0/3] smack: add file label preserve mechanism
>
> Hi Casey,
>
> Thanks again for the earlier guidance. I've dropped the preserve mechanism
> as discussed — the ecp example made the write-down flaw clear.
>
> Let me restate the concrete problem I'm still trying to solve, because
> it is
> narrower than the original patch and I want to check whether there is a
> cleaner native mechanism I'm overlooking.
>
> Context: I'm designing a channel-classification scheme for an embedded
> device (MIPS, BusyBox) where incoming files are labeled by origin — USB,
> network, and serial each map to an untrusted label (USB_Area, Net_Area,
> Serial_Area). The design goal is that a file's label encodes where it came
> from, so it stays traceable through its lifetime.
>
> The specific gap is FAT32 USB. FAT32 has no xattr support, so per-file
> labels can't be stored on the stick. The only way to label stick
> content is
> the mount-time default:
>
>     mount -t vfat -o smackfsdef=USB_Area /dev/sda1 /mnt/usb
>
> which makes every file on the mount appear as USB_Area. That part works.
> The problem is the moment content leaves the stick: `cp /mnt/usb/f.txt
> /srv/data/f.txt` creates f.txt with the copying process's label, so the
> USB_Area provenance is silently lost.
>
> From your earlier reply I understand transmuting labels are the intended
> tool, and indeed copying into a transmuting quarantine directory preserves
> the label — our ingress path already does exactly that. The case I can't
> close is the later approval step: when an administrator moves a file
> out of
> the quarantine into a normal data directory, the label is lost again
> unless
> the administrator relabels explicitly.
>
> So the question is narrower than preserve: is there an established SMACK
> pattern for "a file that originated on a smackfsdef mount keeps that
> provenance across a copy or move", beyond explicit chsmack at every step?

How about trying a special program cp_usbarea which uses a SMACK64_EXEC
attribute to always run with your USB_Area label? You would need a rule

	USB_Area <label-of-destination> rw

to allow the program to write in the destination directory. cp_usbarea
would need to be trusted to some level, but not to the extent a root
or CAP_MAC_ADMIN process would require.

>
> I currently solve it in userspace (a small cp wrapper that copies the
> source
> label with chsmack after the copy, which works because chsmack is
> privileged), but I'd rather not invent a mechanism if SMACK already
> has one
> for this case.
>
> Thanks for your time.
>
> Regards,
> Tang Pengke
> ------------------------------------------------------------------------
> *发件人:* Casey Schaufler <casey@schaufler-ca.com>
> *发送时间:* 2026年8月19日 0:11
> *收件人:* Tang Peter <Peter_Towne@hotmail.com>
> *抄送:* linux-security-module@vger.kernel.org
> <linux-security-module@vger.kernel.org>; Casey Schaufler
> <casey@schaufler-ca.com>
> *主题:* Re: [RFC PATCH 0/3] smack: add file label preserve mechanism
>  
> On 8/18/2026 1:05 AM, Tang Peter wrote:
> > Subject: [RFC PATCH 0/3] smack: add file label preserve mechanism
> >
> > Hi Casey,
> >
> > I'm working on an embedded Linux device (MIPS, BusyBox) that uses SMACK
> > for mandatory access control, and I ran into a problem that I think is
> > worth your opinion on.
> >
> > Problem
> > -------
> > When a user copies a file with BusyBox cp, the destination file inherits
> > the *process* label rather than the *source* file's label.
>
> This is the correct and expected behavior. A process that creates
> a new file has the opportunity to put whatever data it desires in it,
> so the new file has to have the process label, regardless of any labeling
> of the source information.
>
> Cases like this are why Smack has transmuting labels. Without more
> information
> about the specifics of your directory hierarchy and labeling strategy it's
> hard to offer specific advice, but if what you have is a limited set
> of files
> that require label preservation you should be able to use that mechanism.
>
> >  On desktop or
> > server systems this is solved in userspace -- GNU cp has
> > --preserve=context, and SELinux has restorecond. But on an embedded
> > device with BusyBox, neither is available, and the result is that the
> > source file's label (e.g. an untrusted "USB" label) is silently lost
> > after the copy, which breaks both access control and audit tracing.
> >
> > Proposed mechanism
> > ------------------
> > An opt-in "preserve" feature controlled via /sys/fs/smackfs/preserve
> > (default off):
> >
> >   1. smack_file_open(): when a regular file is opened O_RDONLY,
> >      record its label into task_smack::smk_preserve. Shared library
> >      loads under /lib/ and /usr/lib/ are skipped (path-prefix filter)
> >      so ld.so does not pollute the preserve slot.
> >
> >   2. smack_inode_init_security(): if smk_preserve is set, use it as
> >      the new inode's label and clear it. TRANSMUTE still takes
> >      priority, so existing transmuting-directory behaviour is unchanged.
> >
> >   3. The slot is one-shot: cleared on use, on fork (cred_prepare),
> >      and on exec (bprm_creds_for_exec), so it only applies to a
> >      "read then create" sequence within a single process.
> >
> > This makes `cp a b`, `cat a > b`, and similar BusyBox workflows keep
> > the source label without any userspace changes.
>
> I have an evil program "ecp", which uses this mechanism. ecp opens a
> file labeled "_", and creates a new executable file /bin/xyzzy. It then
> opens a file labeled "somethingelse", which contains a malicious program.
> /bin/xyzzy is filled with the malicious program. Now, processes that
> have no access to somethingelse are exposed to the malicious program.
>
> You could restrict smk_preserve to programs with CAP_MAC_ADMIN, but
> such a process could relabel the file directly, rendering the mechanism
> unnecessary.
>
> >
> > Questions
> > ---------
> > - Does this approach make sense for SMACK, or is there an existing /
> >   preferred way to solve this that I've missed?
> > - Any concerns about the one-shot slot semantics, or the /lib/ filter?
> >
> > Thanks,
> > Tang Pengke
> >
> > ---
> >  security/smack/smack.h     |  2 ++
> >  security/smack/smack_lsm.c | 45
> > +++++++++++++++++++++++++++++++++++++++++----
> >  security/smack/smackfs.c   | 50
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 93 insertions(+), 4 deletions(-)
> >
> >
> > From: Tang Pengke <peter_towne@hotmail.com>
> > Subject: [RFC PATCH 1/3] smack: add smk_preserve field to task_smack
> >
> > Add a smk_preserve pointer to struct task_smack for recording
> > the label of the last file opened read-only. Also declare the
> > global smack_preserve toggle variable.
> >
> > Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> > ---
> >  security/smack/smack.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index 8ad30955e15..c6eea57cf52 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -124,6 +124,7 @@ struct task_smack {
> >       struct list_head  smk_rules;  /* per task access rules */
> >       struct mutex            smk_rules_lock;   /* lock for the rules */
> >       struct list_head  smk_relabel;      /* transit allowed labels */
> > +     struct smack_known      *smk_preserve;    /* label to preserve
> > on create */
> >  };
> >  
> >  #define    SMK_INODE_INSTANT 0x01  /* inode is instantiated */
> > @@ -325,6 +326,7 @@ extern struct smack_known *smack_unconfined;
> >  #endif
> >  extern int smack_ptrace_rule;
> > +extern int smack_preserve;
> >  extern struct lsm_blob_sizes smack_blob_sizes;
> >  
> >  extern struct smack_known smack_known_floor;
> >
> >
> > From: Tang Pengke <peter_towne@hotmail.com>
> > Subject: [RFC PATCH 2/3] smack: implement file label preserve mechanism
> >
> > When smack_preserve is enabled, opening a regular file read-only
> > records its label in task_smack::smk_preserve. On the next file
> > creation (smack_inode_init_security), that label is applied to the
> > new inode -- unless TRANSMUTE takes priority.
> >
> > The preserve is one-shot:
> >   - Consumed immediately on new inode creation
> >   - Cleared on fork (smack_cred_prepare)
> >   - Cleared on exec (smack_bprm_creds_for_exec)
> >
> > Shared library loads under /lib/ and /usr/lib/ are explicitly
> > excluded from recording, so ld.so does not pollute the preserve
> > label during exec. Non-regular files (directories, devices) are
> > also skipped.
> >
> > This enables tools like cp and 'cat > file' to create files that
> > retain the source file's label, without requiring any userspace
> > changes. The feature is disabled by default (preserve=0).
> >
> > Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> > ---
> >  security/smack/smack_lsm.c | 45
> > +++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 41 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 11f238e94..951c79d9e 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -935,6 +935,7 @@ static int smack_bprm_creds_for_exec(struct
> > linux_binprm *bprm)
> >             return -EPERM;
> >  
> >       bsp->smk_task = isp->smk_task;
> > +     bsp->smk_preserve = NULL;
> >       bprm->per_clear |= PER_CLEAR_ON_SETID;
> >  
> >       /* Decide if this is a secure exec. */
> > @@ -1066,6 +1067,15 @@ static int smack_inode_init_security(struct
> > inode *inode, struct inode *dir,
> >             }
> >       }
> >  
> > +     /*
> > +      * If a preserve label was recorded on file open, use it
> > +      * for the new inode (unless TRANSMUTE already applied above).
> > +      */
> > +     if (tsp->smk_preserve != NULL) {
> > +           issp->smk_inode = tsp->smk_preserve;
> > +           tsp->smk_preserve = NULL;
> > +     }
> > +
> >       if (rc == 0)
> >             if (xattr_dupval(xattrs, xattr_count,
> >                       XATTR_SMACK_SUFFIX,
> > @@ -2064,6 +2074,27 @@ static int smack_file_open(struct file *file)
> >       struct smk_audit_info ad;
> >       int rc;
> >  
> > +     if (smack_preserve && (file->f_flags & O_ACCMODE) == O_RDONLY) {
> > +           char *buf;
> > +           const char *path;
> > +
> > +           if (!S_ISREG(inode->i_mode))
> > +                 goto skip_preserve;
> > +
> > +           buf = kmalloc(PATH_MAX, GFP_KERNEL);
> > +           if (!buf)
> > +                 goto skip_preserve;
> > +
> > +           path = dentry_path_raw(file->f_path.dentry, buf, PATH_MAX);
> > +           if (!IS_ERR(path) &&
> > +               strncmp(path, "/lib/", 5) != 0 &&
> > +               strncmp(path, "/usr/lib/", 9) != 0)
> > +                 tsp->smk_preserve = smk_of_inode(inode);
> > +
> > +           kfree(buf);
> > +     }
> > +skip_preserve:
> > +
> >       smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
> >       smk_ad_setfield_u_fs_path(&ad, file->f_path);
> >       rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
> > @@ -2129,6 +2160,7 @@ static int smack_cred_prepare(struct cred *new,
> > const struct cred *old,
> >       int rc;
> >  
> >       init_task_smack(new_tsp, old_tsp->smk_task, old_tsp->smk_task);
> > +     new_tsp->smk_preserve = NULL;
> >  
> >       rc = smk_copy_rules(&new_tsp->smk_rules, &old_tsp->smk_rules,
> gfp);
> >       if (rc != 0)
> >
> >
> > From: Tang Pengke <peter_towne@hotmail.com>
> > Subject: [RFC PATCH 3/3] smack: add /sys/fs/smackfs/preserve interface
> >
> > Expose the smack_preserve toggle via smackfs. Reading returns '0'
> > or '1'. Writing '0' or '1' toggles the feature (requires
> > CAP_MAC_ADMIN). Default is disabled (0) so existing systems are
> > unaffected.
> >
> > Signed-off-by: Tang Pengke <peter_towne@hotmail.com>
> > ---
> >  security/smack/smackfs.c | 50
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> > index a3a55a25360..8379ef73cf2 100644
> > --- a/security/smack/smackfs.c
> > +++ b/security/smack/smackfs.c
> > @@ -62,6 +62,7 @@ enum smk_inos {
> >       SMK_NET6ADDR      = 23, /* single label IPv6 hosts */
> >  #endif /* CONFIG_IPV6 */
> >       SMK_RELABEL_SELF = 24, /* relabel possible without
> CAP_MAC_ADMIN */
> > +     SMK_PRESERVE      = 25, /* label preserve on copy */
> >  };
> >  
> >  /*
> > @@ -2047,6 +2048,53 @@ static ssize_t smk_write_onlycap(struct file
> > *file, const char __user *buf,
> >       return rc;
> >  }
> >  
> > +int smack_preserve;
> > +
> > +static ssize_t smk_read_preserve(struct file *filp, char __user *buf,
> > +                         size_t cn, loff_t *ppos)
> > +{
> > +     char val[2];
> > +
> > +     if (*ppos != 0)
> > +           return 0;
> > +
> > +     val[0] = smack_preserve ? '1' : '0';
> > +     val[1] = '\n';
> > +
> > +     return simple_read_from_buffer(buf, cn, ppos, val, 2);
> > +}
> > +
> > +static ssize_t smk_write_preserve(struct file *file, const char
> > __user *buf,
> > +                          size_t count, loff_t *ppos)
> > +{
> > +     char data;
> > +
> > +     if (!smack_privileged(CAP_MAC_ADMIN))
> > +           return -EPERM;
> > +
> > +     if (*ppos != 0)
> > +           return -EINVAL;
> > +
> > +     if (copy_from_user(&data, buf, 1) != 0)
> > +           return -EFAULT;
> > +
> > +     if (data == '0')
> > +           smack_preserve = 0;
> > +     else if (data == '1')
> > +           smack_preserve = 1;
> > +     else
> > +           return -EINVAL;
> > +
> > +     return count;
> > +}
> > +
> > +static const struct file_operations smk_preserve_ops = {
> > +     .read       = smk_read_preserve,
> > +     .write            = smk_write_preserve,
> > +     .llseek           = default_llseek,
> > +};
> > +
> >  static const struct file_operations smk_onlycap_ops = {
> >       .open       = smk_open_onlycap,
> >       .read       = seq_read,
> > @@ -2933,6 +2981,8 @@ static int smk_fill_super(struct super_block
> > *sb, struct fs_context *fc)
> >             [SMK_RELABEL_SELF] = {
> >                   "relabel-self", &smk_relabel_self_ops,
> >                         S_IRUGO|S_IWUGO},
> > +           [SMK_PRESERVE] = {
> > +                 "preserve", &smk_preserve_ops, S_IRUGO|S_IWUSR},
> >             /* last one */
> >                   {""}
> >       };
