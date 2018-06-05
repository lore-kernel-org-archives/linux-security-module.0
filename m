From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 5 Jun 2018 07:29:21 -0700
Subject: [PATCH] Smack: Fix memory leak in smack_inode_getsecctx
In-Reply-To: <20180605070449epcms5p317013469ed52cc50878011c428bd12aa@epcms5p3>
References: <20180604212704.GC1351649@devbig577.frc2.facebook.com>
	<1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
	<20180531153943.GR1351649@devbig577.frc2.facebook.com>
	<4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
	<20180531161107.GV1351649@devbig577.frc2.facebook.com>
	<20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
	<20180601162913epcms5p7737f5b4376d8865af1eae119aa866550@epcms5p7>
	<5b0b157a-0e8c-d8f5-901e-836d545a8e4c@schaufler-ca.com>
	<fa278910-5c99-11dc-c9cb-b88a97592e53@schaufler-ca.com>
	<b6cc4bd5-8d79-bbc2-373f-ea0bf0806884@schaufler-ca.com>
	<CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcms5p3>
	<20180605070449epcms5p317013469ed52cc50878011c428bd12aa@epcms5p3>
Message-ID: <9fdb7658-0440-4402-cda6-7f1426ea24e6@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/5/2018 12:04 AM, CHANDAN VN wrote:
> ?
>
>> On?Mon,?Jun?04,?2018?at?02:01:34PM?-0700,?Casey?Schaufler?wrote:
>>> ?On?6/1/2018?10:45?AM,?Casey?Schaufler?wrote:
>>> ?>?Fix?memory?leak?in?smack_inode_getsecctx
>>> ?>
>>> ?>?The?implementation?of?smack_inode_getsecctx()?made
>>> ?>?incorrect?assumptions?about?how?Smack?presents?a?security
>>> ?>?context.?Smack?does?not?need?to?allocate?memory?to?support
>>> ?>?security?contexts,?so?"releasing"?a?Smack?context?is?a?no-op.
>>> ?>?The?code?made?an?unnecessary?copy?and?returned?that?as?a
>>> ?>?context,?which?was?never?freed.?The?revised?implementation
>>> ?>?returns?the?context?correctly.
>>> ?>
>>> ?>?Signed-off-by:?Casey?Schaufler?<casey@schaufler-ca.com>
>>> ?
>>> ?Tejun,?does?this?pass?your?tests?
> ?
>> Oh,?I'm?not?the?one?who?reported.??Chandan?
> Looks good to me. Leak not found.

Thanks. Can I add your "Tested-by:" on the commit?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
