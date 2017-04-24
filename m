From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Mon, 24 Apr 2017 14:14:05 -0300
Subject: [PATCH 3/6] ima: Simplify policy_func_show.
In-Reply-To: <1492783076.3081.202.camel@linux.vnet.ibm.com>
References: <1492546666-16615-1-git-send-email-bauerman@linux.vnet.ibm.com>
	<2085797.x18HOhjl0i@morokweng>
	<1492783076.3081.202.camel@linux.vnet.ibm.com>
Message-ID: <9111285.IvmltpgZRA@morokweng>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Am Freitag, 21. April 2017, 09:57:56 BRT schrieb Mimi Zohar:
> On Thu, 2017-04-20 at 17:40 -0300, Thiago Jung Bauermann wrote:
> > @@ -949,49 +936,16 @@ void ima_policy_stop(struct seq_file *m, void *v)
> > 
> >  #define pt(token)	policy_tokens[token + Opt_err].pattern
> >  #define mt(token)	mask_tokens[token]
> > 
> > -#define ft(token)	func_tokens[token]
> > 
> >  /*
> >  
> >   * policy_func_show - display the ima_hooks policy rule
> >   */
> >  
> >  static void policy_func_show(struct seq_file *m, enum ima_hooks func)
> >  {
> > 
> > -	char tbuf[64] = {0,};
> > -
> > -	switch (func) {
> > -	case FILE_CHECK:
> > -		seq_printf(m, pt(Opt_func), ft(func_file));
> > -		break;
> > -	case MMAP_CHECK:
> > -		seq_printf(m, pt(Opt_func), ft(func_mmap));
> > -		break;
> > -	case BPRM_CHECK:
> > -		seq_printf(m, pt(Opt_func), ft(func_bprm));
> > -		break;
> > -	case MODULE_CHECK:
> > -		seq_printf(m, pt(Opt_func), ft(func_module));
> > -		break;
> > -	case FIRMWARE_CHECK:
> > -		seq_printf(m, pt(Opt_func), ft(func_firmware));
> > -		break;
> > -	case POST_SETATTR:
> > -		seq_printf(m, pt(Opt_func), ft(func_post));
> > -		break;
> > -	case KEXEC_KERNEL_CHECK:
> > -		seq_printf(m, pt(Opt_func), ft(func_kexec_kernel));
> > -		break;
> > -	case KEXEC_INITRAMFS_CHECK:
> > -		seq_printf(m, pt(Opt_func), ft(func_kexec_initramfs));
> > -		break;
> > -	case POLICY_CHECK:
> > -		seq_printf(m, pt(Opt_func), ft(func_policy));
> > -		break;
> > -	default:
> > -		snprintf(tbuf, sizeof(tbuf), "%d", func);
> > -		seq_printf(m, pt(Opt_func), tbuf);
> > -		break;
> > -	}
> > -	seq_puts(m, " ");
> > +	if (func > 0 && func < MAX_CHECK)
> > +		seq_printf(m, "func=%s ", func_tokens[func]);
> > +	else
> > +		seq_printf(m, "func=%d ", func);
> 
> The only time this can happen is when __kernel_read_file_id() is
> updated without updating the read_idmap[].  Perhaps we can display the
> number and the appropriate __kernel_read_file_id string.

>From what I understood of the code func comes from ima_parse_rule, so that 
condition would only happen if ima_parse_rule got out of sync with 
func_tokens. Since that code only initializes func with constants from enum 
ima_hooks and this patch makes ima_hooks automatically sync with func_tokens, 
the else branch is more like a "can't happen" safety net.

read_idmap is only used in ima_post_read_file, and I couldn't see a relation 
between that code path and the one for ima_policy_show.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
