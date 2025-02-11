﻿using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace TutorMe.Models
{
    public partial class Request
    {
        public Guid RequestId { get; set; }
        public Guid TuteeId { get; set; }
        public Guid TutorId { get; set; }
        public string DateCreated { get; set; }
        public Guid ModuleId { get; set; }


        [JsonIgnore]
        public virtual User Tutee { get; set; }
        [JsonIgnore]
        public virtual User Tutor { get; set; }
        [JsonIgnore]
        public virtual Module Module { get; set; }
    }
}