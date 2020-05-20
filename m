Return-Path: <SRS0=Q/5P=7C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D911C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 22:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D6720884
	for <linux-security-module@archiver.kernel.org>; Wed, 20 May 2020 22:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgETWQI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 May 2020 18:16:08 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56886 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETWQH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 May 2020 18:16:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbX0J-0004ci-NS; Wed, 20 May 2020 16:15:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jbX0I-0003hG-NN; Wed, 20 May 2020 16:15:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
Date:   Wed, 20 May 2020 17:12:10 -0500
In-Reply-To: <877dx822er.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 19:29:00 -0500")
Message-ID: <87d06ygssl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jbX0I-0003hG-NN;;;mid=<87d06ygssl.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ZjgT5a7YJjLyuJqkSbC8pgMniL4vFhnY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 0/8] exec: Control flow simplifications
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


I have pushed this out to:

git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next

I have collected up the acks and reviewed-by's, and fixed a couple of
typos but that is it.

If we need comment fixes or additional cleanups we can apply that on top
of this series.   This way the code can sit in linux-next until the
merge window opens.

Before I pushed this out I also tested this with Kees new test of
binfmt_misc and did not find any problems.

Eric

The git range-diff of the changes I applied before pushing this out:

1:  f6bb0d6563ca ! 1:  87b047d2be41 exec: Teach prepare_exec_creds how exec treats uids & gids
    @@ Commit message
         update bprm->cred are just need to handle special cases such
         as setuid exec and change of domains.
     
    +    Link: https://lkml.kernel.org/r/871rng22dm.fsf_-_@x220.int.ebiederm.org
    +    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## kernel/cred.c ##
2:  d3b3594be22f ! 2:  b8bff599261c exec: Factor security_bprm_creds_for_exec out of security_bprm_set_creds
    @@ Commit message
         Add or upate comments a appropriate to bring them up to date and
         to reflect this change.
     
    +    Link: https://lkml.kernel.org/r/87v9kszrzh.fsf_-_@x220.int.ebiederm.org
    +    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Acked-by: Casey Schaufler <casey@schaufler-ca.com> # For the LSM and Smack bits
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/exec.c ##
3:  65c651a77967 ! 3:  d9d67b76eed6 exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
    @@ Commit message
         In short two renames and a move in the location of initializing
         bprm->active_secureexec.
     
    +    Link: https://lkml.kernel.org/r/87o8qkzrxp.fsf_-_@x220.int.ebiederm.org
    +    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/exec.c ##
4:  6d0d5da2b45e ! 4:  dbf17e846ea9 exec: Allow load_misc_binary to call prepare_binfmt unconditionally
    @@ Metadata
     Author: Eric W. Biederman <ebiederm@xmission.com>
     
      ## Commit message ##
    -    exec: Allow load_misc_binary to call prepare_binfmt unconditionally
    +    exec: Allow load_misc_binary to call prepare_binprm unconditionally
     
         Add a flag preserve_creds that binfmt_misc can set to prevent
         credentials from being updated.  This allows binfmt_misc to always
    -    call prepare_binfmt.  Allowing the credential computation logic to be
    +    call prepare_binprm.  Allowing the credential computation logic to be
         consolidated.
     
         Not replacing the credentials with the interpreters credentials is
    @@ Commit message
         exec sees.
     
         Ref: c407c033de84 ("[PATCH] binfmt_misc: improve calculation of interpreter's credentials")
    +    Link: https://lkml.kernel.org/r/87imgszrwo.fsf_-_@x220.int.ebiederm.org
    +    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/binfmt_misc.c ##
5:  af7db65c2483 ! 5:  8a8f3bb8ec41 exec: Move the call of prepare_binprm into search_binary_handler
    @@ Commit message
         search_binary_handler is called so move the call into search_binary_handler
         itself to make the code simpler and easier to understand.
     
    +    Link: https://lkml.kernel.org/r/87d070zrvx.fsf_-_@x220.int.ebiederm.org
    +    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
    +    Reviewed-by: James Morris <jamorris@linux.microsoft.com>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## arch/alpha/kernel/binfmt_loader.c ##
6:  69fccdf33a87 ! 6:  01dbc34d75bf exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC
    @@ Commit message
         has been take that the logic of the parsing code (short of replacing
         characters by '\0') remains the same.
     
    +    Link: https://lkml.kernel.org/r/874ksczru6.fsf_-_@x220.int.ebiederm.org
    +    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/binfmt_script.c ##
7:  30fe957c6dce ! 7:  6962a6b4de92 exec: Generic execfd support
    @@ Commit message
         In binfmt_misc the movement of fd_install into generic code means
         that it's special error exit path is no longer needed.
     
    +    Link: https://lkml.kernel.org/r/87y2poyd91.fsf_-_@x220.int.ebiederm.org
    +    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/binfmt_elf.c ##
    @@ fs/exec.c: int begin_new_exec(struct linux_binprm * bprm)
      	 */
      	set_mm_exe_file(bprm->mm, bprm->file);
      
    -+	/* If the binary is not readable than enforce mm->dumpable=0 */
    ++	/* If the binary is not readable then enforce mm->dumpable=0 */
      	would_dump(bprm, bprm->file);
     +	if (bprm->have_execfd)
     +		would_dump(bprm, bprm->executable);
8:  f0a27d0fde69 ! 8:  226ce5863881 exec: Remove recursion from search_binary_handler
    @@ Commit message
         reassignments of bprm->file moved to exec_binprm bprm->file can never
         be NULL in search_binary_handler.
     
    +    Link: https://lkml.kernel.org/r/87sgfwyd84.fsf_-_@x220.int.ebiederm.org
    +    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## arch/alpha/kernel/binfmt_loader.c ##

