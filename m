From: jlee@suse.com (joeyli)
Date: Fri, 20 Oct 2017 14:44:31 +0800
Subject: [PATCH 13/27] asus-wmi: Restrict debugfs interface when the
	kernel is locked down
In-Reply-To: <150842473184.7923.9538070958624850416.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842473184.7923.9538070958624850416.stgit@warthog.procyon.org.uk>
Message-ID: <20171020064431.GU3285@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 19, 2017 at 03:52:11PM +0100, David Howells wrote:
> From: Matthew Garrett <matthew.garrett@nebula.com>
> 
> We have no way of validating what all of the Asus WMI methods do on a given
> machine - and there's a risk that some will allow hardware state to be
> manipulated in such a way that arbitrary code can be executed in the
> kernel, circumventing module loading restrictions.  Prevent that if the
> kernel is locked down.
> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

I have reviewed this patch. Please feel free to add:

Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>

Thanks!
Joey Lee

> cc: acpi4asus-user at lists.sourceforge.net
> cc: platform-driver-x86 at vger.kernel.org
> ---
> 
>  drivers/platform/x86/asus-wmi.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 48e1541dc8d4..ef5587469337 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1905,6 +1905,9 @@ static int show_dsts(struct seq_file *m, void *data)
>  	int err;
>  	u32 retval = -1;
>  
> +	if (kernel_is_locked_down("Asus WMI"))
> +		return -EPERM;
> +
>  	err = asus_wmi_get_devstate(asus, asus->debug.dev_id, &retval);
>  
>  	if (err < 0)
> @@ -1921,6 +1924,9 @@ static int show_devs(struct seq_file *m, void *data)
>  	int err;
>  	u32 retval = -1;
>  
> +	if (kernel_is_locked_down("Asus WMI"))
> +		return -EPERM;
> +
>  	err = asus_wmi_set_devstate(asus->debug.dev_id, asus->debug.ctrl_param,
>  				    &retval);
>  
> @@ -1945,6 +1951,9 @@ static int show_call(struct seq_file *m, void *data)
>  	union acpi_object *obj;
>  	acpi_status status;
>  
> +	if (kernel_is_locked_down("Asus WMI"))
> +		return -EPERM;
> +
>  	status = wmi_evaluate_method(ASUS_WMI_MGMT_GUID,
>  				     0, asus->debug.method_id,
>  				     &input, &output);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
