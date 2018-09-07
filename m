From: tonyj@suse.de (Tony Jones)
Date: Fri, 7 Sep 2018 16:53:31 -0700
Subject: [PATCH] apparmor: Fix network performance issue in
	aa_label_sk_perm
In-Reply-To: <c7676cd4-6ffe-0c6d-8d77-3fd20d692254@canonical.com>
References: <20180907043357.4638-1-tonyj@suse.de>
	<c7676cd4-6ffe-0c6d-8d77-3fd20d692254@canonical.com>
Message-ID: <6d1908de-aa62-dc63-cc60-8883358d257c@suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 09/07/2018 09:37 AM, John Johansen wrote:

> hey Tony,
> 
> thanks for the patch, I am curious did you're investigation look
> into what parts of DEFINE_AUDIT_SK are causing the issue?

Hi JJ.

Attached are the perf annotations for DEFINE_AUDIT_SK (percentages are relative to the fn).   
Our kernel performance testing is carried out with default installs which means AppArmor 
is enabled but the performance tests are unconfined. It was obvious that the overhead of 
DEFINE_AUDIT_SK was significant for smaller packet sizes (typical of synthetic benchmarks) 
and that it didn't need to execute for the unconfined case,  hence the patch.  I didn't 
spend any time looking at the performance of confined tasks.  It may be worth your time to 
look at this.

Comparing my current tip (2601dd392dd1) to tip+patch I'm seeing an increase of 3-6% in netperf
throughput for packet sizes 64-1024.

HTH

Tony

 Percent |	Source code & Disassembly of vmlinux for cycles:ppp (117 samples)
---------------------------------------------------------------------------------
         :
         :
         :
         :                      Disassembly of section .text:
         :
         :                      ffffffff813fbec0 <aa_label_sk_perm>:
         :                      aa_label_sk_perm():
         :                                                                 type));
         :                      }
         :
         :                      static int aa_label_sk_perm(struct aa_label *label, const char *op, u32 request,
         :                                                  struct sock *sk)
         :                      {
    0.00 :   ffffffff813fbec0:       callq  ffffffff81a017f0 <__fentry__>
    2.56 :   ffffffff813fbec5:       push   %r14
    0.00 :   ffffffff813fbec7:       mov    %rcx,%r14
         :                              struct aa_profile *profile;
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbeca:       mov    $0x7,%ecx
         :                      {
    0.00 :   ffffffff813fbecf:       push   %r13
    3.42 :   ffffffff813fbed1:       mov    %edx,%r13d
    0.00 :   ffffffff813fbed4:       push   %r12
    0.00 :   ffffffff813fbed6:       push   %rbp
    0.00 :   ffffffff813fbed7:       mov    %rdi,%rbp
    5.13 :   ffffffff813fbeda:       push   %rbx
    0.00 :   ffffffff813fbedb:       sub    $0xb8,%rsp
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbee2:       movzwl 0x10(%r14),%r9d
         :                      {
    1.71 :   ffffffff813fbee7:       mov    %gs:0x28,%rax
    0.00 :   ffffffff813fbef0:       mov    %rax,0xb0(%rsp)
    0.00 :   ffffffff813fbef8:       xor    %eax,%eax
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbefa:       lea    0x78(%rsp),%rdx
    1.71 :   ffffffff813fbeff:       lea    0x20(%rsp),%r8
    0.00 :   ffffffff813fbf04:       movq   $0x0,(%rsp)
    0.00 :   ffffffff813fbf0c:       movq   $0x0,0x10(%rsp)
    0.00 :   ffffffff813fbf15:       mov    %rdx,%rdi
   14.53 :   ffffffff813fbf18:       rep stos %rax,%es:(%rdi)
    1.71 :   ffffffff813fbf1b:       mov    $0xb,%ecx
    0.00 :   ffffffff813fbf20:       mov    %r8,%rdi
    0.00 :   ffffffff813fbf23:       mov    %r14,0x80(%rsp)
   18.80 :   ffffffff813fbf2b:       rep stos %rax,%es:(%rdi)
    0.00 :   ffffffff813fbf2e:       mov    %rsi,0x28(%rsp)
    1.71 :   ffffffff813fbf33:       mov    %r9w,0x88(%rsp)
    0.00 :   ffffffff813fbf3c:       cmp    $0x1,%r9w
    0.00 :   ffffffff813fbf41:       je     ffffffff813fbfa1 <aa_label_sk_perm+0xe1>
    0.00 :   ffffffff813fbf43:       mov    $0x2,%eax
    0.00 :   ffffffff813fbf48:       test   %r14,%r14
    0.00 :   ffffffff813fbf4b:       je     ffffffff813fbfa1 <aa_label_sk_perm+0xe1>
   14.53 :   ffffffff813fbf4d:       mov    %al,(%rsp)
    0.00 :   ffffffff813fbf50:       movzwl 0x1ea(%r14),%eax
         :                              AA_BUG(!sk);
         :
         :                              if (unconfined(label))
         :                                      return 0;
         :
         :                              return fn_for_each_confined(label, profile,
    0.00 :   ffffffff813fbf58:       xor    %r12d,%r12d
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbf5b:       mov    %r8,0x18(%rsp)
    8.55 :   ffffffff813fbf60:       mov    %eax,0x58(%rsp)
    0.00 :   ffffffff813fbf64:       movzbl 0x1e9(%r14),%eax
    0.00 :   ffffffff813fbf6c:       mov    %rdx,0x8(%rsp)
    0.00 :   ffffffff813fbf71:       mov    %eax,0x5c(%rsp)
         :                              if (unconfined(label))
    8.55 :   ffffffff813fbf75:       testb  $0x2,0x40(%rbp)
    0.00 :   ffffffff813fbf79:       je     ffffffff813fbfa8 <aa_label_sk_perm+0xe8>
         :                                              aa_profile_af_sk_perm(profile, &sa, request, sk));
         :                      }
    0.00 :   ffffffff813fbf7b:       mov    0xb0(%rsp),%rdx
    0.00 :   ffffffff813fbf83:       xor    %gs:0x28,%rdx
    4.27 :   ffffffff813fbf8c:       mov    %r12d,%eax
    0.00 :   ffffffff813fbf8f:       jne    ffffffff813fbfe5 <aa_label_sk_perm+0x125>
    0.00 :   ffffffff813fbf91:       add    $0xb8,%rsp
    0.00 :   ffffffff813fbf98:       pop    %rbx
    5.13 :   ffffffff813fbf99:       pop    %rbp
    0.00 :   ffffffff813fbf9a:       pop    %r12
    0.00 :   ffffffff813fbf9c:       pop    %r13
    0.00 :   ffffffff813fbf9e:       pop    %r14
    7.69 :   ffffffff813fbfa0:       retq
         :                              DEFINE_AUDIT_SK(sa, op, sk);
    0.00 :   ffffffff813fbfa1:       mov    $0x7,%eax
    0.00 :   ffffffff813fbfa6:       jmp    ffffffff813fbf4d <aa_label_sk_perm+0x8d>
         :                              return fn_for_each_confined(label, profile,
    0.00 :   ffffffff813fbfa8:       xor    %esi,%esi
    0.00 :   ffffffff813fbfaa:       jmp    ffffffff813fbfcd <aa_label_sk_perm+0x10d>
         :                      aa_profile_af_sk_perm():
         :                      static inline int aa_profile_af_sk_perm(struct aa_profile *profile,
         :                                                              struct common_audit_data *sa,
         :                                                              u32 request,
         :                                                              struct sock *sk)
         :                      {
         :                              return aa_profile_af_perm(profile, sa, request, sk->sk_family,
    0.00 :   ffffffff813fbfac:       movzwl 0x10(%r14),%ecx
    0.00 :   ffffffff813fbfb1:       movzwl 0x1ea(%r14),%r8d
    0.00 :   ffffffff813fbfb9:       mov    %rsp,%rsi
    0.00 :   ffffffff813fbfbc:       mov    %r13d,%edx
    0.00 :   ffffffff813fbfbf:       callq  ffffffff813fbdf0 <aa_profile_af_perm>
         :                      aa_label_sk_perm():
    0.00 :   ffffffff813fbfc4:       lea    0x1(%rbx),%esi
    0.00 :   ffffffff813fbfc7:       test   %eax,%eax
    0.00 :   ffffffff813fbfc9:       cmovne %eax,%r12d
    0.00 :   ffffffff813fbfcd:       mov    %rbp,%rdi
    0.00 :   ffffffff813fbfd0:       callq  ffffffff813f7310 <aa_label_next_confined>
    0.00 :   ffffffff813fbfd5:       mov    %eax,%ebx
    0.00 :   ffffffff813fbfd7:       cltq
    0.00 :   ffffffff813fbfd9:       mov    0x50(%rbp,%rax,8),%rdi
    0.00 :   ffffffff813fbfde:       test   %rdi,%rdi
    0.00 :   ffffffff813fbfe1:       jne    ffffffff813fbfac <aa_label_sk_perm+0xec>
    0.00 :   ffffffff813fbfe3:       jmp    ffffffff813fbf7b <aa_label_sk_perm+0xbb>
         :                      }
    0.00 :   ffffffff813fbfe5:       callq  ffffffff81090d60 <__stack_chk_fail>
